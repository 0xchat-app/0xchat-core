import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:nostr_core_dart/nostr.dart';

/// notice callback
typedef NoticeCallBack = void Function(String notice, String relay);

/// send event callback
typedef OKCallBack = void Function(
    OKEvent ok, String relay, List<String> unCompletedRelays);

/// request callback
typedef EventCallBack = void Function(Event event, String relay);
typedef EOSECallBack = void Function(
    String requestId, OKEvent ok, String relay, List<String> unCompletedRelays);

/// connect callback
typedef ConnectStatusCallBack = void Function(String relay, int status);

class Sends {
  String sendsId;
  List<String> relays;
  int sendsTime;
  String eventId;
  OKCallBack? okCallBack;

  Sends(
      this.sendsId, this.relays, this.sendsTime, this.eventId, this.okCallBack);
}

class Requests {
  String requestId;
  List<String> relays;
  int requestTime;
  Map<String, String> subscriptions;
  EventCallBack? eventCallBack;
  EOSECallBack? eoseCallBack;

  Requests(this.requestId, this.relays, this.requestTime, this.subscriptions,
      this.eventCallBack, this.eoseCallBack);
}

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

  // subscriptionId+relay, Requests
  Map<String, Requests> requestsMap = {};
  // send event callback
  Map<String, Sends> sendsMap = {};
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
    Iterable<String> okMapKeys = List<String>.from(sendsMap.keys);
    for (var eventId in okMapKeys) {
      var start = sendsMap[eventId]!.sendsTime;
      if (now - start > timeout * 1000) {
        // timeout
        OKEvent ok = OKEvent(eventId, false, 'Time Out');
        if (sendsMap[eventId]!.okCallBack != null) {
          for (var relay in sendsMap[eventId]!.relays) {
            sendsMap[eventId]!.okCallBack!(ok, relay, []);
          }
          sendsMap.remove(eventId);
        }
      }
    }
    Iterable<String> requestMapKeys = List<String>.from(requestsMap.keys);
    for (var subscriptionId in requestMapKeys) {
      if (requestsMap[subscriptionId] != null) {
        var start = requestsMap[subscriptionId]!.requestTime;
        if (start > 0 && now - start > timeout * 1000) {
          // timeout
          EOSECallBack? callBack = requestsMap[subscriptionId]!.eoseCallBack;
          OKEvent ok = OKEvent(subscriptionId, false, 'Time Out');
          for (var relay in requestsMap[subscriptionId]!.relays) {
            if (callBack != null && requestsMap[subscriptionId] != null) {
              callBack(requestsMap[subscriptionId]!.subscriptions[relay]!, ok,
                  relay, []);
            }
          }
        }
      }
    }
  }

  void _setConnectStatus(String relay, int status) {
    connectStatus[relay] = status;
    connectStatusCallBack?.call(relay, status);
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
    List<String> result = [];
    for (var relay in webSockets.keys) {
      if (connectStatus[relay] == 1) result.add(relay);
    }
    return result;
  }

  Future connect(String relay) async {
    // connecting or open
    if (connectStatus[relay] == 0 || connectStatus[relay] == 1) return;
    WebSocket socket;
    if (webSockets.containsKey(relay) && webSockets[relay] != null) {
      socket = webSockets[relay]!;
      // _setConnectStatus(relay, socket.readyState);
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
    if (webSockets.containsKey(relay)) {
      if (webSockets[relay] != null) webSockets[relay]!.close();
      webSockets.remove(relay);
    }
  }

  String addSubscription(List<Filter> filters,
      {EventCallBack? eventCallBack, EOSECallBack? eoseCallBack}) {
    Map<String, List<Filter>> result = {};
    for (var relay in Connect.sharedInstance.relays()) {
      result[relay] = filters;
    }
    return addSubscriptions(result,
        eventCallBack: eventCallBack, eoseCallBack: eoseCallBack);
  }

  String addSubscriptions(Map<String, List<Filter>> filters,
      {EventCallBack? eventCallBack, EOSECallBack? eoseCallBack}) {
    /// Create a subscription message request with one or many filters
    String requestsId = generate64RandomHexChars();
    Requests requests = Requests(requestsId, filters.keys.toList(),
        DateTime.now().millisecondsSinceEpoch, {}, eventCallBack, eoseCallBack);
    for (String relay in filters.keys) {
      Request requestWithFilter =
          Request(generate64RandomHexChars(), filters[relay]!);
      String subscriptionString = requestWithFilter.serialize();

      /// add request to request map
      requests.subscriptions[relay] = requestWithFilter.subscriptionId;
      requestsMap[requestWithFilter.subscriptionId + relay] = requests;

      /// Send a request message to the WebSocket server
      _send(subscriptionString, relay: relay);
    }
    return requestsId;
  }

  Future closeSubscription(String subscriptionId, String relay) async {
    print(Close(subscriptionId).serialize());
    if (subscriptionId.isNotEmpty) {
      _send(Close(subscriptionId).serialize(), relay: relay);

      /// remove the mapping
      requestsMap.remove(subscriptionId + relay);
    } else {
      throw Exception("null subscriptionId");
    }
  }

  Future closeRequests(String requestId) async {
    Iterable<String> requestsMapKeys = List<String>.from(requestsMap.keys);
    for (var key in requestsMapKeys) {
      var requests = requestsMap[key];
      if (requests!.requestId == requestId) {
        for (var relay in relays()) {
          if (requests.subscriptions[relay] != null) {
            await closeSubscription(requests.subscriptions[relay]!, relay);
          }
        }
        return;
      }
    }
  }

  /// send an event to relay/relays
  void sendEvent(Event event, {OKCallBack? sendCallBack}) {
    print(event.serialize());
    Sends sends = Sends(generate64RandomHexChars(), relays(),
        DateTime.now().millisecondsSinceEpoch, event.id, sendCallBack);
    sendsMap[event.id] = sends;
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
        _handleEvent(m.message, relay);
        break;
      case "EOSE":
        _handleEOSE(m.message, relay);
        break;
      case "NOTICE":
        _handleNotice(m.message, relay);
        break;
      case "OK":
        _handleOk(message, relay);
        break;
      default:
        print('Received message not supported: $message');
        break;
    }
  }

  void _handleEvent(Event event, String relay) {
    print('Received event: ${event.serialize()}');
    String? subscriptionId = event.subscriptionId;
    if (subscriptionId != null) {
      String requestsMapKey = subscriptionId + relay;
      if (subscriptionId.isNotEmpty &&
          requestsMap.containsKey(requestsMapKey)) {
        EventCallBack? callBack = requestsMap[requestsMapKey]!.eventCallBack;
        if (callBack != null) callBack(event, relay);
      }
    }
  }

  void _handleEOSE(String eose, String relay) {
    print('receive EOSE: $eose');
    String subscriptionId = jsonDecode(eose)[0];
    String requestsMapKey = subscriptionId + relay;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      var relays = requestsMap[requestsMapKey]!.relays;
      relays.remove(relay);
      // all relays have EOSE
      EOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
      OKEvent ok = OKEvent(subscriptionId, true, '');
      if (callBack != null) callBack(subscriptionId, ok, relay, relays);
    }
  }

  void _handleNotice(String notice, String relay) {
    print('receive notice: $notice');
    String n = jsonDecode(notice)[0];
    noticeCallBack?.call(n, relay);
  }

  void _handleOk(String message, String relay) {
    print('receive ok: $message');
    OKEvent? ok = Nip20.getOk(message);
    if (ok != null && sendsMap.containsKey(ok.eventId)) {
      if (sendsMap[ok.eventId]!.okCallBack != null) {
        var relays = sendsMap[ok.eventId]!.relays;
        relays.remove(relay);
        sendsMap[ok.eventId]!.okCallBack!(ok, relay, relays);
        if (relays.isEmpty) sendsMap.remove(ok.eventId);
      }
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
      if (webSockets.containsKey(relay)) {
        await Future.delayed(Duration(milliseconds: 3000));
        return await _connectWs(relay);
      }
    }
  }

  Future<void> _onDisconnected(String relay) async {
    print("_onDisconnected");
    _setConnectStatus(relay, 3); // closed
    await Future.delayed(Duration(milliseconds: 3000));
    connect(relay);
  }
}
