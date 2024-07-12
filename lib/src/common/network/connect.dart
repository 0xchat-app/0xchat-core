import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
  String eventString;

  Sends(this.sendsId, this.relays, this.sendsTime, this.eventId,
      this.okCallBack, this.eventString);
}

class Requests {
  String requestId;
  List<String> relays;
  int requestTime;
  Map<String, String> subscriptions;
  EventCallBack? eventCallBack;
  EOSECallBack? eoseCallBack;
  String subscriptionString;

  Requests(this.requestId, this.relays, this.requestTime, this.subscriptions,
      this.eventCallBack, this.eoseCallBack, this.subscriptionString);
}

class AuthData {
  String challenge;
  String eventId;
  List<String> resendDatas;

  AuthData(this.challenge, this.eventId, this.resendDatas);
}

class ISocket {
  WebSocket? socket;

  /// connecting = 0;
  /// open = 1;
  /// closing = 2;
  /// closed = 3;
  int connectStatus;
  RelayKind relayKind;

  ISocket(this.socket, this.connectStatus, this.relayKind);
}

enum RelayKind {
  general,
  dm,
  relayGroup,
  secretChat,
  nwc,
  temp,
}

class Connect {
  Connect._internal() {
    startHeartBeat();
    listenConnectivity();
  }
  factory Connect() => sharedInstance;
  static final Connect sharedInstance = Connect._internal();

  // 15 seconds time out
  static final int timeout = 15;

  NoticeCallBack? noticeCallBack;
  ConnectStatusCallBack? connectStatusCallBack;
  StreamSubscription? _connectivitySubscription;

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
  // relay AUTH
  Map<String, AuthData> auths = {};

  List<String> eventCache = [];

  Map<String, List<Future<bool>>> eventCheckerFutures = {};

  void startHeartBeat() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        _checkTimeout();
      });
    }
  }

  void listenConnectivity() {
    // Listen for connectivity changes
    _connectivitySubscription ??= Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        for (var socket in webSockets.values) {
          await socket.socket?.close();
        }
      }
    });
  }

  // void _stopCheckTimeOut() {
  //   if (timer != null && timer!.isActive) {
  //     timer!.cancel();
  //   }
  // }

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
              callBack(requestsMap[subscriptionId]!.subscriptions[relay] ?? '',
                  ok, relay, []);
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

  List<String> relays({RelayKind relayKind = RelayKind.general}) {
    List<String> result = [];
    for (var relay in webSockets.keys) {
      if (webSockets[relay]?.connectStatus == 1 &&
          webSockets[relay]?.relayKind == relayKind) result.add(relay);
    }
    return result;
  }

  Future<void> connect(String relay,
      {RelayKind relayKind = RelayKind.general}) async {
    print('connect to $relay, kind: ${relayKind.name}');
    if (relay.isEmpty) return;
    RelayKind? preKind = webSockets[relay]?.relayKind;

    // already exit, don't change the kind
    if (preKind != null && preKind != RelayKind.temp) {
      relayKind = preKind;
    }
    // connecting or open
    if (webSockets[relay]?.connectStatus == 0 ||
        webSockets[relay]?.connectStatus == 1) return;
    WebSocket? socket;
    if (webSockets.containsKey(relay) && webSockets[relay] != null) {
      socket = webSockets[relay]!.socket;
      // _setConnectStatus(relay, socket.readyState);
      print('$relay status = ${webSockets[relay]?.connectStatus}');
      if (webSockets[relay]?.connectStatus != 3) {
        /// not closed
        return;
      }
    }
    print("connecting... $relay");
    webSockets[relay] = ISocket(null, 0, relayKind);
    try {
      socket = await _connectWs(relay);
      if (socket != null) {
        socket.done.then((dynamic _) => _onDisconnected(relay));
        _listenEvent(socket, relay);
        webSockets[relay] = ISocket(socket, 1, relayKind);
        print("socket connection initialized");
        _setConnectStatus(relay, 1);
      }
    } catch (_) {
      _onDisconnected(relay);
    }
  }

  Future<void> connectRelays(List<String> relays,
      {RelayKind relayKind = RelayKind.general}) async {
    final completer = Completer<void>();
    for (String relay in relays) {
      connect(relay, relayKind: relayKind).then((value) {
        if (!completer.isCompleted) completer.complete();
      });
    }
    return completer.future;
  }

  Future closeConnects(List<String> relays) async {
    await Future.forEach(relays, (relay) async {
      await closeConnect(relay);
    });
  }

  Future closeTempConnects(List<String> relays) async {
    await Future.forEach(relays, (relay) async {
      if (webSockets[relay]?.relayKind == RelayKind.temp) {
        await closeConnect(relay);
      }
    });
  }

  Future closeAllConnects() async {
    await Future.forEach(webSockets.keys, (relay) async {
      await closeConnect(relay);
    });
  }

  Future closeConnect(String relay) async {
    print('closeConnect ${webSockets[relay]?.socket}');
    final socket = webSockets[relay]?.socket;
    webSockets.remove(relay);
    await socket?.close();
  }

  String addSubscription(List<Filter> filters,
      {EventCallBack? eventCallBack,
      EOSECallBack? eoseCallBack,
      List<String>? relays,
      RelayKind relayKind = RelayKind.general}) {
    Map<String, List<Filter>> result = {};
    if (relays != null) {
      relays = relays
          .where((relay) =>
              relay.isNotEmpty &&
              (relay.startsWith('ws://') || relay.startsWith('wss://')))
          .toList();
    }
    List<String> subscriptionRelays = relays?.isNotEmpty == true
        ? relays!
        : Connect.sharedInstance.relays(relayKind: relayKind);
    if (subscriptionRelays.isEmpty) {
      eoseCallBack?.call('', OKEvent('', false, 'no relays connected'), '', []);
      return '';
    }
    for (var relay in subscriptionRelays) {
      result[relay] = filters;
    }
    return addSubscriptions(result,
        eventCallBack: eventCallBack, eoseCallBack: eoseCallBack);
  }

  String addSubscriptions(Map<String, List<Filter>> filters,
      {EventCallBack? eventCallBack, EOSECallBack? eoseCallBack}) {
    /// Create a subscription message request with one or many filters
    String requestsId = generate64RandomHexChars();
    for (String relay in filters.keys) {
      Request requestWithFilter =
          Request(generate64RandomHexChars(), filters[relay]!);
      String subscriptionString = requestWithFilter.serialize();

      /// add request to request map
      Requests requests = Requests(
          requestsId,
          filters.keys.toList(),
          DateTime.now().millisecondsSinceEpoch,
          {},
          eventCallBack,
          eoseCallBack,
          subscriptionString);
      requests.subscriptions[relay] = requestWithFilter.subscriptionId;
      requestsMap[requestWithFilter.subscriptionId + relay] = requests;

      /// Send a request message to the WebSocket server
      _send(subscriptionString, toRelays: [relay]);

      print('$subscriptionString, $relay');
    }
    return requestsId;
  }

  Future closeSubscription(String subscriptionId, String relay) async {
    print(Close(subscriptionId).serialize());
    if (subscriptionId.isNotEmpty) {
      _send(Close(subscriptionId).serialize(), toRelays: [relay]);

      /// remove the mapping
      requestsMap.remove(subscriptionId + relay);
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
  void sendEvent(Event event,
      {OKCallBack? sendCallBack,
      List<String>? toRelays,
      RelayKind relayKind = RelayKind.general}) {
    String eventString = event.serialize();
    print('send event: $eventString');
    toRelays = (toRelays == null || toRelays.isEmpty)
        ? relays(relayKind: relayKind)
        : toRelays;
    Sends sends = Sends(
        generate64RandomHexChars(),
        toRelays,
        DateTime.now().millisecondsSinceEpoch,
        event.id,
        sendCallBack,
        eventString);
    sendsMap[event.id] = sends;
    _send(eventString, toRelays: toRelays);
  }

  void _send(String data, {List<String>? toRelays}) {
    if (toRelays != null && toRelays.isNotEmpty) {
      for (var relay in toRelays) {
        if (webSockets.containsKey(relay)) {
          var socket = webSockets[relay]?.socket;
          if (webSockets[relay]?.connectStatus == 1 && socket != null) {
            socket.add(data);
          }
        }
      }
    } else {
      webSockets.forEach((url, socket) {
        if (webSockets[url]?.connectStatus == 1 && socket.socket != null) {
          socket.socket?.add(data);
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
      case "CLOSED":
        _handleCLOSED(m.message, relay);
        break;
      case "NOTICE":
        _handleNotice(m.message, relay);
        break;
      case "OK":
        _handleOk(m.message, relay);
        break;
      case "AUTH":
        _handleAuth(m.message, relay);
        break;
      default:
        print('Received message not supported: $message');
        break;
    }
  }

  Future<bool> _checkValidEvent(Event event, String relay) async {
    String? subscriptionId = event.subscriptionId;
    if (subscriptionId != null) {
      String requestsMapKey = subscriptionId + relay;

      if (subscriptionId.isNotEmpty &&
          requestsMap.containsKey(requestsMapKey)) {
        EventCallBack? callBack = requestsMap[requestsMapKey]!.eventCallBack;
        if (callBack != null) {
          // check sign
          if (await event.isValid() == false) {
            return false;
          }
          callBack(event, relay);
          return true;
        }
      }
    }
    return false;
  }

  Future<void> _handleEvent(Event event, String relay) async {
    print('Received event: ${event.serialize()}, $relay');
    if (eventCache.contains(event.id)) return;
    // add to cache
    eventCache.add(event.id);
    // ignore the expired event
    if (Nip40.expired(event)) return;

    Future<bool> future = _checkValidEvent(event, relay);
    if (event.subscriptionId != null && event.subscriptionId!.isNotEmpty) {
      eventCheckerFutures[event.subscriptionId!] ??= [];
      eventCheckerFutures[event.subscriptionId!]?.add(future);
    }
  }

  Future<void> _handleEOSE(String eose, String relay) async {
    print('receive EOSE: $eose, $relay');
    String subscriptionId = jsonDecode(eose)[0];
    String requestsMapKey = subscriptionId + relay;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      if (eventCheckerFutures.containsKey(subscriptionId)) {
        await Future.wait(eventCheckerFutures[subscriptionId]!);
        eventCheckerFutures.remove(subscriptionId);
      }
      _removeRequestsMapRelay(subscriptionId, relay);
      var relays = requestsMap[requestsMapKey]?.relays;
      if (relays != null) {
        // all relays have EOSE
        EOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
        OKEvent ok = OKEvent(subscriptionId, true, '');
        if (callBack != null) callBack(subscriptionId, ok, relay, relays);
      }
    }
  }

  void _handleCLOSED(Closed closed, String relay) {
    print('receive closed: ${closed.serialize()}, $relay');
    String subscriptionId = closed.subscriptionId;
    String requestsMapKey = subscriptionId + relay;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      // check auth
      if (Nip42.authRequired(closed.message)) {
        String subscriptionString =
            requestsMap[requestsMapKey]!.subscriptionString;
        if (auths[relay]?.resendDatas.contains(subscriptionString) == false) {
          auths[relay]?.resendDatas.add(subscriptionString);
        }
        _sendAuth(relay);
        return;
      }
      _removeRequestsMapRelay(subscriptionId, relay);
      var relays = requestsMap[requestsMapKey]!.relays;
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
      _removeRequestsMapRelay(requestsMapKey.replaceAll(relay, ''), relay);
      var relays = requestsMap[requestsMapKey]!.relays;
      // all relays have EOSE
      String subscriptionId = requestsMapKey.replaceAll(relay, '');
      EOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
      OKEvent ok = OKEvent(subscriptionId, false, n);
      if (callBack != null) callBack(subscriptionId, ok, relay, relays);
    }

    noticeCallBack?.call(n, relay);
  }

  Future<void> _handleOk(OKEvent ok, String relay) async {
    print('receive ok: ${ok.serialize()}, $relay');
    // check auth response
    if (auths[relay]?.eventId == ok.eventId) {
      if (ok.status) {
        for (var data in auths[relay]?.resendDatas ?? []) {
          print('re-send: $data');
          _send(data, toRelays: [relay]);
        }
      }
      auths.remove(relay);
      return;
    }
    if (sendsMap.containsKey(ok.eventId)) {
      // check need auth
      if (!ok.status && Nip42.authRequired(ok.message)) {
        String eventString = sendsMap[ok.eventId]!.eventString;
        if (auths[relay]?.resendDatas.contains(eventString) == false) {
          auths[relay]?.resendDatas.add(eventString);
        }
        _sendAuth(relay);
        return;
      }
      if (sendsMap[ok.eventId]!.okCallBack != null) {
        var relays = sendsMap[ok.eventId]!.relays;
        relays.remove(relay);
        if (ok.status || relays.isEmpty) {
          sendsMap[ok.eventId]!.okCallBack!(ok, relay);
          sendsMap.remove(ok.eventId);
        } else if (!ok.status && ok.eventId.isEmpty) {
          List<String> requestsMapKeys = requestsMap.keys
              .where((element) => element.contains(relay))
              .toList();
          for (var requestsMapKey in requestsMapKeys) {
            _removeRequestsMapRelay(
                requestsMapKey.replaceAll(relay, ''), relay);
            var relays = requestsMap[requestsMapKey]!.relays;
            // all relays have EOSE
            String subscriptionId = requestsMapKey.replaceAll(relay, '');
            EOSECallBack? callBack = requestsMap[requestsMapKey]!.eoseCallBack;
            if (callBack != null) {
              OKEvent okEvent = OKEvent(subscriptionId, false, ok.message);
              callBack(subscriptionId, okEvent, relay, relays);
            }
          }
        }
      }
    }
  }

  void _handleAuth(Auth auth, String relay) {
    print('receive auth: ${auth.challenge}');
    if (!auths.containsKey(relay)) {
      auths[relay] = AuthData(auth.challenge, '', []);
    } else if (auths[relay]?.challenge != auth.challenge) {
      auths[relay]?.challenge = auth.challenge;
      auths[relay]?.eventId = '';
    }
  }

  void _removeRequestsMapRelay(String subscriptionId, String removeRelay) {
    var requestsMapKey = subscriptionId + removeRelay;
    var request = requestsMap[requestsMapKey];
    if (request == null) return;
    for (var r in requestsMap.values) {
      if (r.requestId == request.requestId) {
        r.relays.remove(removeRelay);
      }
    }
  }

  Future<void> _sendAuth(String relay) async {
    String? challenge = auths[relay]?.challenge;
    if (challenge == null || challenge.isEmpty) return;
    String? eventId = auths[relay]?.eventId;
    if (eventId?.isNotEmpty == true) return;
    auths[relay]!.eventId = 'sending...';
    Event event = await Nip42.encode(
        challenge,
        relay,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    var authJson = Nip42.authString(event);
    auths[relay]!.eventId = event.id;
    print('send auth: $authJson');
    _send(authJson, toRelays: [relay]);
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
      print("Error! can not connect WS connectWs $e relay:$relay");
      _setConnectStatus(relay, 3); // closed
      if (webSockets.containsKey(relay)) {
        await Future.delayed(Duration(milliseconds: 3000));
        return await connect(relay);
      }
    }
  }

  Future<void> _onDisconnected(String relay) async {
    print("_onDisconnected");
    _setConnectStatus(relay, 3); // closed
    if (webSockets.containsKey(relay)) {
      await Future.delayed(Duration(milliseconds: 3000));
      return await connect(relay);
    }
  }
}
