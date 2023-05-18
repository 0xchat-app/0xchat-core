import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:nostr_core_dart/nostr.dart';

typedef EventCallBack = void Function(Event event);
/// 0:end without event, 1:end with events
typedef EOSECallBack = void Function(int status);
typedef NoticeCallBack = void Function(String notice);
typedef OKCallBack = void Function(Ok ok);
typedef ConnectStatusCallBack = void Function(String relay, int status);

class Connect {
  Connect._internal();

  factory Connect() => sharedInstance;

  static final Connect sharedInstance = Connect._internal();

  NoticeCallBack? noticeCallBack;
  ConnectStatusCallBack? connectStatusCallBack;

  /// sockets
  Map<String, WebSocket> webSockets = {};
  /// connecting = 0;
  /// open = 1;
  /// closing = 2;
  /// closed = 3;
  Map<String, int> connectStatus = {};

  /// subscriptionId, EventCallBack
  Map<String, List> map = {};
  // send event callback
  Map<String, OKCallBack> okMap = {};

  void _setConnectStatus(String relay, int status){
    connectStatus[relay] = status;
    if(connectStatusCallBack != null) {
      connectStatusCallBack!(relay, status);
    }
  }

  Future connect(String relay) async {
    // connecting or open
    if (connectStatus[relay] == 0 || connectStatus[relay] == 1) return;
    WebSocket socket;
    if (webSockets.containsKey(relay)) {
      socket = webSockets[relay]!;
      _setConnectStatus(relay, socket.readyState);
      print('status =  ${connectStatus[relay]}');
      if (connectStatus[relay] != 3) {
        /// not closed
        return;
      }
    }
    print("connecting...");
    socket = await _connectWs(relay);
    print("socket connection initialized");
    socket.done.then((dynamic _) => _onDisconnected(relay));
    _listenEvent(socket, relay);
    webSockets[relay] = socket;
  }

  Future connectRelays(List<String> relays) async {
    for (String relay in relays) {
      await connect(relay);
    }
  }

  Future closeConnect(String relay) async {
    if (webSockets.containsKey(relay)) {
      webSockets[relay]!.close();
      webSockets.remove(relay);
    }
  }

  String addSubscription(List<Filter> filters,
      {EventCallBack? eventCallBack, EOSECallBack? eoseCallBack}) {
    /// Create a subscription message request with one or many filters
    Request requestWithFilter = Request(generate64RandomHexChars(), filters);
    String subscriptionString = requestWithFilter.serialize();
    /// Send a request message to the WebSocket server
    webSockets.forEach((relay, socket) => socket.add(subscriptionString));

    /// store subscriptionId & callBack mapping
    map[requestWithFilter.subscriptionId] = [eventCallBack, eoseCallBack, 0];
    return requestWithFilter.subscriptionId;
  }

  Future closeSubscription(String subscriptionId) async {
    if(subscriptionId.isNotEmpty){
      webSockets.forEach(
              (relay, socket) => socket.add(Close(subscriptionId).serialize()));

      /// remove the mapping
      map.remove(subscriptionId);
    }
    else {
      throw Exception("null subscriptionId");
    }
  }

  /// send an event to relay
  void sendEvent(Event event, {OKCallBack? sendCallBack}) {
    print(event.serialize());
    if (sendCallBack != null) okMap[event.id] = sendCallBack;
    webSockets.forEach((relay, socket) => socket.add(event.serialize()));
  }

  void _handleMessage(String message) {
    var m = Message.deserialize(message);
    switch (m.type) {
      case "EVENT":
        _handleEvent(m.message);
        break;
      case "EOSE":
        _handleEOSE(m.message);
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
    if (subscriptionId != null && subscriptionId.isNotEmpty) {
      EventCallBack? callBack = map[subscriptionId]![0];
      map[subscriptionId]![2] = 1;
      if (callBack != null) callBack(event);
    }
  }

  void _handleEOSE(String eose) {
    print('receive EOSE: $eose');
    String subscriptionId = jsonDecode(eose)[0];
    if (subscriptionId.isNotEmpty && map.containsKey(subscriptionId)) {
      EOSECallBack? callBack = map[subscriptionId]![1];
      if (callBack != null) callBack(map[subscriptionId]![2]);
    }
  }

  void _handleNotice(String notice) {
    print('receive notice: $notice');
    String n = jsonDecode(notice)[0];
    if (noticeCallBack != null) noticeCallBack!(n);
  }

  void _handleOk(String message) {
    print('receive ok: $message');
    Ok? ok = Nip20.getOk(message);
    if (ok != null && okMap.containsKey(ok.eventId)) okMap[ok.eventId]!(ok);
  }

  void _listenEvent(WebSocket socket, String relay) {
    socket.listen((message) {
      _handleMessage(message);
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
