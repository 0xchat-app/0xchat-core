import 'dart:core';
import 'dart:io';
import 'package:nostr/nostr.dart';

typedef EventCallBack = void Function(Event event);

class Connect {
  Connect._internal();

  factory Connect() => _instance;

  static final Connect _instance = Connect._internal();

  /// socket
  late WebSocket webSocket;

  /// subscriptionId, EventCallBack
  Map<String, EventCallBack> map = {};

  Future connect(String relay) async {
    /// Connecting to a nostr relay using websocket
    webSocket = await WebSocket.connect(relay);
    webSocket.listen((message) {
      _handleMessage(message);
    });
  }

  Future closeConnect() async {
    await webSocket.close();
  }

  Future reConnect(String relay) async {
    await webSocket.close(000, "change relay");
    connect(relay);
  }

  String addSubscription(List<Filter> filters, EventCallBack callBack) {
    /// Create a subscription message request with one or many filters
    Request requestWithFilter = Request(generate64RandomHexChars(), filters);
    String subscriptionId = requestWithFilter.serialize();

    /// Send a request message to the WebSocket server
    webSocket.add(subscriptionId);

    /// store subscriptionId & callBack mapping
    map[subscriptionId] = callBack;
    return subscriptionId;
  }

  Future closeSubscription(String subscriptionId) async {
    Close(subscriptionId);
    /// remove the mapping
    map.remove(subscriptionId);
  }

  /// send an event to relay
  void sendEvent(Event event) {
    webSocket.add(event.serialize());
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
      EventCallBack? callBack = map[subscriptionId];
      if (callBack != null) callBack(event);
    }
  }

  void _handleEOSE(String subscriptionId) {
    print('receive EOSE: $subscriptionId');
  }

  void _handleNotice(String notice) {
    print('receive notice: $notice');
  }
}
