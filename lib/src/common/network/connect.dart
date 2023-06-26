import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:nostr_core_dart/nostr.dart';

typedef EventCallBack = void Function(Event event);

/// 0:end without event, 1:end with events
typedef EOSECallBack = void Function(int status);
typedef NoticeCallBack = void Function(String notice);
typedef OKCallBack = void Function(OKEvent ok);
typedef ConnectStatusCallBack = void Function(String relay, int status);

class Connect {
  Connect._internal() {
    _startCheckTimeOut();
  }
  factory Connect() => sharedInstance;
  static final Connect sharedInstance = Connect._internal();

  // 15 seconds time out
  static final int timeout = 15;

  NoticeCallBack? noticeCallBack;
  ConnectStatusCallBack? connectStatusCallBack;

  /// sockets
  Map<String, WebSocket?> webSockets = {};

  /// connecting = 0;
  /// open = 1;
  /// closing = 2;
  /// closed = 3;
  Map<String, int> connectStatus = {};

  // subscriptionId, EventCallBack
  Map<String, List> requestMap = {};
  // send event callback
  Map<String, List> okMap = {};
  // ConnectStatus listeners
  List<ConnectStatusCallBack> connectStatusListeners = [];
  // for timeout
  Timer? timer;

  void _startCheckTimeOut() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        _checkTimeout();
      });
    }
  }

  void _stopCheckTimeOut() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  void _checkTimeout() {
    var now = DateTime.now().millisecondsSinceEpoch;
    for (var eventId in okMap.keys) {
      var start = okMap[eventId]![1];
      if (now - start > timeout * 1000) {
        // timeout
        OKEvent ok = OKEvent(eventId, false, 'Time Out');
        okMap[eventId]![0](ok);
        okMap.remove(eventId);
      }
    }
    for (var subscriptionId in requestMap.keys) {
      var start = requestMap[subscriptionId]![3];
      if (start > 0 && now - start > timeout * 1000) {
        // timeout
        EOSECallBack? callBack = requestMap[subscriptionId]![1];
        if (callBack != null) callBack(requestMap[subscriptionId]![2]);
      }
    }
  }

  void _setConnectStatus(String relay, int status) {
    connectStatus[relay] = status;
    if (connectStatusCallBack != null) {
      connectStatusCallBack!(relay, status);
    }
    for (var callBack in connectStatusListeners) {
      callBack(relay, status);
    }
  }

  void addConnectStatusListener(ConnectStatusCallBack callBack) {
    if (!connectStatusListeners.contains(callBack)) {
      connectStatusListeners.add(callBack);
    }
  }

  void removeConnectStatusListener(ConnectStatusCallBack callBack) {
    if (connectStatusListeners.contains(callBack)) {
      connectStatusListeners.remove(callBack);
    }
  }

  List<String> relays() {
    return webSockets.keys.toList();
  }

  Future connect(String relay) async {
    // connecting or open
    if (connectStatus[relay] == 0 || connectStatus[relay] == 1) return;
    WebSocket socket;
    if (webSockets.containsKey(relay) && webSockets[relay] != null) {
      socket = webSockets[relay]!;
      _setConnectStatus(relay, socket.readyState);
      print('status =  ${connectStatus[relay]}');
      if (connectStatus[relay] != 3) {
        /// not closed
        return;
      }
    }
    print("connecting...");
    webSockets[relay] = null;
    socket = await _connectWs(relay);
    socket.done.then((dynamic _) => _onDisconnected(relay));
    _listenEvent(socket, relay);
    webSockets[relay] = socket;
    print("socket connection initialized");
    _setConnectStatus(relay, 1);
  }

  Future connectRelays(List<String> relays) async {
    for (String relay in relays) {
      connect(relay);
    }
  }

  Future closeConnect(String relay) async {
    if (webSockets.containsKey(relay) && webSockets[relay] != null) {
      webSockets[relay]!.close();
      webSockets.remove(relay);
    }
  }

  String addSubscription(List<Filter> filters,
      {String? relay,
      EventCallBack? eventCallBack,
      EOSECallBack? eoseCallBack,
      bool? needTimeout}) {
    /// Create a subscription message request with one or many filters
    Request requestWithFilter = Request(generate64RandomHexChars(), filters);
    String subscriptionString = requestWithFilter.serialize();

    /// Send a request message to the WebSocket server
    _send(subscriptionString, relay: relay);

    /// store subscriptionId & callBack mapping
    requestMap[requestWithFilter.subscriptionId] = [
      eventCallBack,
      eoseCallBack,
      0,
      (needTimeout != null && needTimeout)
          ? DateTime.now().millisecondsSinceEpoch
          : 0,
      relay == null ? webSockets.keys.toList() : [relay]
    ];
    return requestWithFilter.subscriptionId;
  }

  Future closeSubscription(String subscriptionId, {String? relay}) async {
    print(Close(subscriptionId).serialize());
    if (subscriptionId.isNotEmpty) {
      _send(Close(subscriptionId).serialize(), relay: relay);

      /// remove the mapping
      requestMap.remove(subscriptionId);
    } else {
      throw Exception("null subscriptionId");
    }
  }

  /// send an event to relay
  void sendEvent(Event event, {OKCallBack? sendCallBack}) {
    print(event.serialize());
    if (sendCallBack != null) {
      okMap[event.id] = [sendCallBack, DateTime.now().millisecondsSinceEpoch];
    }
    _send(event.serialize());
  }

  void _send(String data, {String? relay}) {
    if (relay != null) {
      if (webSockets.containsKey(relay)) {
        var socket = webSockets[relay];
        if (connectStatus[relay] == 1 && socket != null) {
          socket.add(data);
        }
      }
    } else {
      webSockets.forEach((url, socket) {
        if (connectStatus[url] == 1 && socket != null) {
          socket.add(data);
        }
      });
    }
  }

  void _handleMessage(String message, String relay) {
    var m = Message.deserialize(message);
    switch (m.type) {
      case "EVENT":
        _handleEvent(m.message);
        break;
      case "EOSE":
        _handleEOSE(m.message, relay);
        break;
      case "NOTICE":
        _handleNotice(m.message);
        break;
      case "OK":
        _handleOk(message);
        break;
      default:
        print('Received message not supported: $message');
        break;
    }
  }

  void _handleEvent(Event event) {
    print('Received event: ${event.serialize()}');
    String? subscriptionId = event.subscriptionId;
    if (subscriptionId != null &&
        subscriptionId.isNotEmpty &&
        requestMap.containsKey(subscriptionId)) {
      EventCallBack? callBack = requestMap[subscriptionId]![0];
      requestMap[subscriptionId]![2] = 1;
      if (callBack != null) callBack(event);
    }
  }

  void _handleEOSE(String eose, String relay) {
    print('receive EOSE: $eose');
    String subscriptionId = jsonDecode(eose)[0];
    if (subscriptionId.isNotEmpty && requestMap.containsKey(subscriptionId)) {
      List<String> relays = requestMap[subscriptionId]![4];
      relays.remove(relay);
      if (relays.isEmpty) {
        // all relays have EOSE
        EOSECallBack? callBack = requestMap[subscriptionId]![1];
        if (callBack != null) callBack(requestMap[subscriptionId]![2]);
      }
    }
  }

  void _handleNotice(String notice) {
    print('receive notice: $notice');
    String n = jsonDecode(notice)[0];
    if (noticeCallBack != null) noticeCallBack!(n);
  }

  void _handleOk(String message) {
    print('receive ok: $message');
    OKEvent? ok = Nip20.getOk(message);
    if (ok != null && okMap.containsKey(ok.eventId)) {
      okMap[ok.eventId]![0](ok);
      okMap.remove(ok.eventId);
    }
  }

  void _listenEvent(WebSocket socket, String relay) {
    socket.listen((message) {
      _handleMessage(message, relay);
    }, onDone: () {
      print("connect aborted");
      _setConnectStatus(relay, 3); // closed
      connect(relay);
    }, onError: (e) {
      print('Server error: $e');
      _setConnectStatus(relay, 3); // closed
      connect(relay);
    });
  }

  Future _connectWs(String relay) async {
    try {
      _setConnectStatus(relay, 0); // connecting
      return await WebSocket.connect(relay);
    } catch (e) {
      print("Error! can not connect WS connectWs $e");
      _setConnectStatus(relay, 3); // closed
      await Future.delayed(Duration(milliseconds: 3000));
      return await _connectWs(relay);
    }
  }

  Future<void> _onDisconnected(String relay) async {
    print("_onDisconnected");
    _setConnectStatus(relay, 3); // closed
    await Future.delayed(Duration(milliseconds: 3000));
    connect(relay);
  }
}
