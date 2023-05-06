import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:nostr/nostr.dart';

typedef EventCallBack = void Function(Event event);
typedef EOSECallBack = void Function(
    int status); // 0:end without event, 1:end with events
typedef NoticeCallBack = void Function(String notice);

class Connect {
  Connect._internal();

  factory Connect() => sharedInstance;

  static final Connect sharedInstance = Connect._internal();

  NoticeCallBack? noticeCallBack;

  /// sockets
  Map<String, WebSocket> webSockets = {};

  /// subscriptionId, EventCallBack
  Map<String, List> map = {};

  Future connect(String relay) async {
    WebSocket socket;
    if (webSockets.containsKey(relay)) {
      socket = webSockets[relay]!;
      int status = socket.readyState;
      print('status =  $status');
      if (status != 3) {
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
    String subscriptionId = requestWithFilter.serialize();

    /// Send a request message to the WebSocket server
    webSockets.forEach((relay, socket) => socket.add(subscriptionId));

    /// store subscriptionId & callBack mapping
    map[requestWithFilter.subscriptionId] = [eventCallBack, eoseCallBack, 0];
    return subscriptionId;
  }

  Future closeSubscription(String subscriptionId) async {
    webSockets.forEach(
        (relay, socket) => socket.add(Close(subscriptionId).serialize()));

    /// remove the mapping
    map.remove(subscriptionId);
  }

  /// send an event to relay
  void sendEvent(Event event) {
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
      default:
        print('Received message not supported: $message');
        break;
    }
  }

  void _handleEvent(Event event) {
    print('Received event: $event');
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
    if (subscriptionId.isNotEmpty) {
      EOSECallBack? callBack = map[subscriptionId]![1];
      if (callBack != null) callBack(map[subscriptionId]![2]);
    }
  }

  void _handleNotice(String notice) {
    print('receive notice: $notice');
    String n = jsonDecode(notice)[0];
    if (noticeCallBack != null) noticeCallBack!(n);
  }

  void _listenEvent(WebSocket socket, String relay) {
    socket.listen((message) {
      _handleMessage(message);
    }, onDone: () {
      print("connect aborted");
      connect(relay);
    }, onError: (e) {
      print('Server error: $e');
      connect(relay);
    });
  }

  Future _connectWs(String relay) async {
    try {
      return await WebSocket.connect(relay);
    } catch (e) {
      print("Error! can not connect WS connectWs $e");
      await Future.delayed(Duration(milliseconds: 10000));
      return await _connectWs(relay);
    }
  }

  void _onDisconnected(String relay) {
    connect(relay);
  }
}
