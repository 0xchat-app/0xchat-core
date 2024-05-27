import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

/// notice callback
typedef NoticeCallBack = void Function(String notice, String relay);

/// send event callback
typedef OKCallBack = void Function(OKEvent ok, String relay);

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

class ISocket {
  WebSocket? socket;

  /// connecting = 0;
  /// open = 1;
  /// closing = 2;
  /// closed = 3;
  int connectStatus;

  /// 0: normal
  /// 1: secret chat
  int type;

  ISocket(this.socket, this.connectStatus, this.type);
}

class Connect {
  Connect._internal() {
    startHeartBeat();
  }
  factory Connect() => sharedInstance;
  static final Connect sharedInstance = Connect._internal();

  // 15 seconds time out
  static final int timeout = 15;

  NoticeCallBack? noticeCallBack;
  ConnectStatusCallBack? connectStatusCallBack;

  /// sockets
  Map<String, ISocket> webSockets = {};

  // subscriptionId+relay, Requests
  Map<String, Requests> requestsMap = {};
  // send event callback
  Map<String, Sends> sendsMap = {};
  // ConnectStatus listeners
  List<ConnectStatusCallBack> connectStatusListeners = [];
  // for timeout
  Timer? timer;

  void startHeartBeat() {
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
            sendsMap[eventId]!.okCallBack!(ok, relay);
          }
          sendsMap.remove(eventId);
        }
      }
    }
    Iterable<String> requestMapKeys = List<String>.from(requestsMap.keys);
    for (var subscriptionId in requestMapKeys) {
      EOSECallBack? callBack = requestsMap[subscriptionId]!.eoseCallBack;
      if (requestsMap[subscriptionId] != null && callBack != null) {
        var start = requestsMap[subscriptionId]!.requestTime;
        if (start > 0 && now - start > timeout * 1000 * 2) {
          // timeout
          OKEvent ok = OKEvent(subscriptionId, false, 'Time Out');
          Iterable<String> relays =
              List<String>.from(requestsMap[subscriptionId]!.relays);
          for (var relay in relays) {
            if (subscriptionId.endsWith(relay)) {
              callBack(requestsMap[subscriptionId]!.subscriptions[relay]!, ok,
                  relay, []);
              requestsMap[subscriptionId]?.relays.remove(relay);
            }
          }
        }
      }
    }
  }

  void _setConnectStatus(String relay, int status) {
    webSockets[relay]?.connectStatus = status;
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

  List<String> relays({int type = 0}) {
    List<String> result = [];
    for (var relay in webSockets.keys) {
      if (webSockets[relay]?.connectStatus == 1 &&
          webSockets[relay]?.type == type) result.add(relay);
    }
    return result;
  }

  Future connect(String relay, {int type = 0}) async {
    if (webSockets[relay]?.type == 0) type = 0;
    // connecting or open
    if (webSockets[relay]?.connectStatus == 0 ||
        webSockets[relay]?.connectStatus == 1) return;
    WebSocket? socket;
    if (webSockets.containsKey(relay) && webSockets[relay] != null) {
      socket = webSockets[relay]!.socket;
      // _setConnectStatus(relay, socket.readyState);
      print('status =  ${webSockets[relay]?.connectStatus}');
      if (webSockets[relay]?.connectStatus != 3) {
        /// not closed
        return;
      }
    }
    print("connecting...");
    webSockets[relay] = ISocket(null, 0, type);
    socket = await _connectWs(relay);
    if (socket != null) {
      socket.done.then((dynamic _) => _onDisconnected(relay));
      _listenEvent(socket, relay);
      webSockets[relay] = ISocket(socket, 1, type);
      print("socket connection initialized");
      _setConnectStatus(relay, 1);
    }
  }

  Future connectRelays(List<String> relays) async {
    for (String relay in relays) {
      connect(relay);
    }
  }

  Future closeConnect(String relay) async {
    print('closeConnect ${webSockets[relay]?.socket}');
    webSockets[relay]?.socket?.close();
    webSockets.remove(relay);
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

      print('$subscriptionString, $relay');
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

  Future closeRequests(String requestId, {String? relay}) async {
    Iterable<String> requestsMapKeys = List<String>.from(requestsMap.keys);
    for (var key in requestsMapKeys) {
      var requests = requestsMap[key];
      if (requests!.requestId == requestId) {
        if (relay != null) {
          if (requests.subscriptions[relay] != null) {
            await closeSubscription(requests.subscriptions[relay]!, relay);
          }
        } else {
          for (var relay in relays()) {
            if (requests.subscriptions[relay] != null) {
              await closeSubscription(requests.subscriptions[relay]!, relay);
            }
          }
        }
        return;
      }
    }
  }

  /// send an event to relay/relays
  void sendEvent(Event event, {OKCallBack? sendCallBack, String? relay}) {
    print(event.serialize());
    Sends sends = Sends(
        generate64RandomHexChars(),
        (relay == null || relay.isEmpty) ? relays() : [relay],
        DateTime.now().millisecondsSinceEpoch,
        event.id,
        sendCallBack);
    sendsMap[event.id] = sends;
    _send(event.serialize(), relay: relay);
  }

  void _send(String data, {String? relay}) {
    if (relay != null) {
      if (webSockets.containsKey(relay)) {
        var socket = webSockets[relay]?.socket;
        if (webSockets[relay]?.connectStatus == 1 && socket != null) {
          socket.add(data);
        }
      }
    } else {
      webSockets.forEach((url, iSocket) {
        if (webSockets[url]?.connectStatus == 1 && iSocket.socket != null) {
          iSocket.socket?.add(data);
        }
      });
    }
  }

  Future<void> _handleMessage(String message, String relay) async {
    var m = await Message.deserialize(message);
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
      case "AUTH":
        _handleAuth(m.message, relay);
        break;
      default:
        print('Received message not supported: $message');
        break;
    }
  }

  void _handleEvent(Event event, String relay) {
    print('Received event: ${event.serialize()}, $relay');

    /// ignore the expired event
    if (Nip40.expired(event)) return;

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
    print('receive EOSE: $eose, $relay');
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
    print('receive notice: $notice, $relay');
    String n = jsonDecode(notice)[0];

    List<String> requestsMapKeys =
    requestsMap.keys.where((element) => element.contains(relay)).toList();
    for (var requestsMapKey in requestsMapKeys) {
      var relays = requestsMap[requestsMapKey]!.relays;
      relays.remove(relay);
      // all relays have EOSE
      String subscriptionId = requestsMapKey.replaceAll(relay, '');
      print('error notice EOSE: $subscriptionId, $relay');
      EOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
      OKEvent ok = OKEvent(subscriptionId, false, n);
      if (callBack != null) callBack(subscriptionId, ok, relay, relays);
    }

    noticeCallBack?.call(n, relay);
  }

  Future<void> _handleOk(String message, String relay) async {
    print('receive ok: $message, $relay');
    OKEvent? ok = await Nip20.getOk(message);
    if (ok != null && sendsMap.containsKey(ok.eventId)) {
      if (sendsMap[ok.eventId]!.okCallBack != null) {
        var relays = sendsMap[ok.eventId]!.relays;
        relays.remove(relay);
        if (ok.status || relays.isEmpty) {
          sendsMap[ok.eventId]!.okCallBack!(ok, relay);
          sendsMap.remove(ok.eventId);
        }
      }
    }
  }

  Future<void> _handleAuth(Auth auth, String relay) async {
    String data = await Nip42.encode(
        auth.challenge,
        relay,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    _send(data, relay: relay);
  }

  Future<void> _connectToRelay(String relay) async {
    if (webSockets.containsKey(relay)) {
      await Future.delayed(Duration(milliseconds: 3000));
      connect(relay);
    }
  }

  void _listenEvent(WebSocket socket, String relay) {
    socket.listen((message) async {
      await _handleMessage(message, relay);
    }, onDone: () async {
      print("connect aborted");
      _setConnectStatus(relay, 3); // closed
      await _connectToRelay(relay);
    }, onError: (e) async {
      print('Server error: $e');
      _setConnectStatus(relay, 3); // closed
      await _connectToRelay(relay);
    });
  }

  Future _connectWs(String relay) async {
    try {
      _setConnectStatus(relay, 0); // connecting
      String? host = Config.sharedInstance.hostConfig[relay];
      if (host != null && host.isNotEmpty) {
        return await WebSocket.connect(host);
      }
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
    await _connectToRelay(relay);
  }
}
