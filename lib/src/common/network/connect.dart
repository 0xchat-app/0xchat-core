import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:bip340/bip340.dart' as bip340;
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

// #region agent log
void _connectDebugLog(String hypothesisId, String location, String message, [Map<String, dynamic>? data]) {
  if (!kDebugMode) return;
  final now = DateTime.now();
  final ts = '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}.${now.millisecond.toString().padLeft(3,'0')}';
  debugPrint('[CONNECT_DEBUG][$ts][$hypothesisId] $location: $message ${data != null ? jsonEncode(data) : ''}');
}
// #endregion

/// notice callback
typedef NoticeCallBack = void Function(String notice, String relay);

/// send event callback
typedef OKCallBack = void Function(OKEvent ok, String relay);

/// request callback
typedef EventCallBack = void Function(Event event, String relay);
typedef EOSECallBack = void Function(
    String requestId, OKEvent ok, String relay, List<String> unCompletedRelays);

/// connect callback
typedef ConnectStatusCallBack = void Function(String relay, int status, List<RelayKind> relayKinds);

class Sends {
  String sendsId;
  List<String> relays;
  int sendsTime;
  String eventId;
  OKCallBack? okCallBack;
  String eventString;

  Sends(this.sendsId, this.relays, this.sendsTime, this.eventId, this.okCallBack, this.eventString);
}

class Requests {
  String requestId;
  List<String> relays;
  int requestTime;
  Map<String, String> subscriptions;
  EventCallBack? eventCallBack;
  EOSECallBack? eoseCallBack;
  String subscriptionString;
  bool closeSubscription;

  Requests(this.requestId, this.relays, this.requestTime, this.subscriptions, this.eventCallBack,
      this.eoseCallBack, this.subscriptionString, this.closeSubscription);
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
  List<RelayKind> relayKinds = [];

  ISocket(this.socket, this.connectStatus, this.relayKinds);
}

// #region agent log - retry limiting helper
class _RelayFailureInfo {
  int retryCount = 0;
  int lastFailTimeMs = 0;
  
  bool shouldSkip(int maxRetries, int backoffSeconds) {
    if (retryCount < maxRetries) return false;
    final now = DateTime.now().millisecondsSinceEpoch;
    final backoffMs = backoffSeconds * 1000;
    return (now - lastFailTimeMs) < backoffMs;
  }
  
  void recordFailure() {
    retryCount++;
    lastFailTimeMs = DateTime.now().millisecondsSinceEpoch;
  }
  
  void reset() {
    retryCount = 0;
    lastFailTimeMs = 0;
  }
}

class _PendingConnection {
  final String relay;
  final RelayKind relayKind;
  final Completer<void> completer;
  _PendingConnection(this.relay, this.relayKind) : completer = Completer<void>();
}
// #endregion

enum RelayKind {
  general,
  dm,
  inbox,
  outbox,
  relayGroup,
  secretChat,
  nwc,
  remoteSigner,
  circleRelay,
  temp,
  search,
}

class Connect {
  Connect._internal() {
    startHeartBeat();
    listenConnectivity();
  }
  factory Connect() => sharedInstance;
  static final Connect sharedInstance = Connect._internal();

  static final int timeout = 10;
  static final int MAX_SUBSCRIPTIONS_COUNT = 15;
  
  // #region agent log - retry limiting
  // On Linux, each failing relay blocks the queue for: retries * timeout + waits.
  // With MAX_RETRY=3, timeout=3s, wait=1.5s: 3*3 + 2*1.5 = 12s per failing relay!
  // With 16+ queued relays, that's 192s (3+ min) of continuous I/O pressure.
  // Reduce to 1 retry on Linux to keep it to 3 + 1.5 + 3 = 7.5s max per relay.
  static final int MAX_RETRY_COUNT = Platform.isLinux ? 1 : 3;
  static final int RETRY_BACKOFF_SECONDS = 300; // 5 minutes backoff after max retries
  // Track relay failures: relay -> {retryCount, lastFailTime}
  final Map<String, _RelayFailureInfo> _relayFailures = {};
  // #endregion

  // #region agent log - concurrency control to prevent main thread blocking
  // On Linux, Flutter frame rendering uses GLib idle callbacks (G_PRIORITY_DEFAULT_IDLE=200)
  // which have LOWER priority than I/O callbacks (G_PRIORITY_DEFAULT=0).
  // Multiple concurrent connections generate continuous I/O events that starve frame rendering.
  // Limit to 1 on Linux to reduce I/O pressure and allow frames to render.
  static final int MAX_CONCURRENT_CONNECTIONS = Platform.isLinux ? 1 : 3;
  int _activeConnectionCount = 0;
  final List<_PendingConnection> _connectionQueue = [];
  // #endregion

  NoticeCallBack? noticeCallBack;
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

  Map<String, List<Future<bool>>> eventCheckerFutures = {};

  Map<String, List<String>> subscriptionsWaitingQueue = {};

  void startHeartBeat() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        _checkTimeout();
      });
    }
    resetConnection(force: false);
  }

  Future<void> resetConnection({bool force = true}) async {
    for (var relay in webSockets.keys) {
      if (webSockets[relay]?.connectStatus != 3 && force) {
        webSockets[relay]?.connectStatus = 3;
        await webSockets[relay]?.socket?.close();
      }
      for (var relayKind in webSockets[relay]?.relayKinds ?? []) {
        connect(relay, relayKind: relayKind);
      }
    }
  }

  void listenConnectivity() {
    _connectivitySubscription ??=
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
      if (results.any((result) => result != ConnectivityResult.none)) {
        resetConnection(force: false);
      }
    });
  }

  // void _stopCheckTimeOut() {
  //   if (timer != null && timer!.isActive) {
  //     timer!.cancel();
  //   }
  // }

  void _checkTimeout() {
    // #region agent log
    final ctStart = DateTime.now();
    final ctTs = '${ctStart.hour.toString().padLeft(2,'0')}:${ctStart.minute.toString().padLeft(2,'0')}:${ctStart.second.toString().padLeft(2,'0')}.${ctStart.millisecond.toString().padLeft(3,'0')}';
    int okTimeouts = 0;
    int reqTimeouts = 0;
    // #endregion
    var now = DateTime.now().millisecondsSinceEpoch;
    Iterable<String> okMapKeys = List<String>.from(sendsMap.keys);
    for (var eventId in okMapKeys) {
      var start = sendsMap[eventId]!.sendsTime;
      if (now - start > timeout * 1000) {
        // ok timeout
        okTimeouts++;
        OKEvent ok = OKEvent(eventId, false, 'Time Out');
        Iterable<String> relays = List<String>.from(sendsMap[eventId]!.relays);
        for (var relay in relays) {
          _handleOk(ok, relay);
        }
      }
    }
    Iterable<String> requestMapKeys = List<String>.from(requestsMap.keys);
    for (var requestMapKey in requestMapKeys) {
      var request = requestsMap[requestMapKey];
      if (request != null) {
        // call closeSubscription type eoseCallBack only once
        if (request.closeSubscription == false && request.eoseCallBack == null) continue;
        var start = request.requestTime;
        if (start > 0 && now - start > timeout * 1000) {
          // request timeout
          reqTimeouts++;
          String relay = requestMapKey.substring(64);
          _handleEOSE(jsonEncode([request.requestId]), relay, true);
        }
      }
    }
    // #region agent log
    final ctDuration = DateTime.now().millisecondsSinceEpoch - ctStart.millisecondsSinceEpoch;
    if (Platform.isLinux) {
      try { File('/Users/bear/Desktop/jenkins/.cursor/debug.log').writeAsStringSync('{"sessionId":"debug-session","hypothesisId":"C","location":"connect.dart:_checkTimeout","message":"_checkTimeout","data":{"ts":"$ctTs","durationMs":$ctDuration,"okTimeouts":$okTimeouts,"reqTimeouts":$reqTimeouts,"sendsMapSize":${sendsMap.length},"requestsMapSize":${requestsMap.length}},"timestamp":${ctStart.millisecondsSinceEpoch}}\n', mode: FileMode.append); } catch(_) {}
      debugPrint('[HEARTBEAT_CT][$ctTs] _checkTimeout: ${ctDuration}ms okT=$okTimeouts reqT=$reqTimeouts sends=${sendsMap.length} reqs=${requestsMap.length}');
    }
    // #endregion
  }

  void _setConnectStatus(String relay, int status) {
    webSockets[relay]?.connectStatus = status;
    for (var callBack in connectStatusListeners) {
      callBack(relay, status, webSockets[relay]?.relayKinds ?? []);
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

  List<String> relays({List<RelayKind> relayKinds = const [RelayKind.general]}) {
    List<String> result = [];
    for (var relay in webSockets.keys) {
      if (webSockets[relay]?.connectStatus == 1 &&
          webSockets[relay]!.relayKinds.any((e) => relayKinds.contains(e))) {
        result.add(relay);
      }
    }
    return result;
  }

  Future<void> connect(String relay, {RelayKind relayKind = RelayKind.general}) async {
    // #region agent log
    _connectDebugLog('B', 'connect:ENTER', 'Connect called', {'relay': relay, 'kind': relayKind.name, 'totalWebSockets': webSockets.length, 'activeConns': _activeConnectionCount, 'queueSize': _connectionQueue.length});
    // #endregion
    LogUtils.v(() => 'connect to $relay, kind: ${relayKind.name}');
    if (relay.isEmpty) return;

    List<RelayKind> relayKinds = webSockets[relay]?.relayKinds ?? [relayKind];
    if (!relayKinds.contains(relayKind)) {
      relayKinds.add(relayKind);
    }
    webSockets[relay]?.relayKinds = relayKinds;
    // connecting or open
    if (webSockets[relay]?.connectStatus == 0 || webSockets[relay]?.connectStatus == 1) {
      // #region agent log
      _connectDebugLog('B', 'connect:SKIP', 'Already connecting/connected', {'relay': relay, 'status': webSockets[relay]?.connectStatus});
      // #endregion
      return;
    }
    
    // #region agent log - concurrency control: queue if too many active connections
    if (_activeConnectionCount >= MAX_CONCURRENT_CONNECTIONS) {
      // Skip if this relay is already in the queue to prevent duplicate entries
      if (_connectionQueue.any((p) => p.relay == relay)) {
        _connectDebugLog('B', 'connect:SKIP_QUEUED', 'Already in queue', {'relay': relay});
        return;
      }
      _connectDebugLog('B', 'connect:QUEUED', 'Queuing connection (concurrency limit)', {'relay': relay, 'activeConns': _activeConnectionCount, 'queueSize': _connectionQueue.length});
      final pending = _PendingConnection(relay, relayKind);
      _connectionQueue.add(pending);
      // Set status to connecting so it won't be re-queued
      webSockets[relay] = ISocket(null, 0, relayKinds);
      return pending.completer.future;
    }
    // #endregion
    
    await _doConnectInternal(relay, relayKind, relayKinds);
  }
  
  // #region agent log - internal connect method with concurrency tracking
  Future<void> _doConnectInternal(String relay, RelayKind relayKind, List<RelayKind> relayKinds) async {
    _activeConnectionCount++;
    _connectDebugLog('B', 'connect:START_INTERNAL', 'Starting connection', {'relay': relay, 'activeConns': _activeConnectionCount});
    
    LogUtils.v(() => "connecting... $relay");
    webSockets[relay] = ISocket(null, 0, relayKinds);
    try {
      WebSocket? socket;
      socket = await _connectWs(relay);
      if (socket != null) {
        // NOTE: Do NOT add socket.done.then(_onDisconnected) here.
        // _listenEvent already handles onDone and onError with _reConnectToRelay.
        // Having both causes DUPLICATE reconnection attempts per disconnect,
        // doubling the connection queue pressure.
        _listenEvent(socket, relay, relayKind);
        webSockets[relay] = ISocket(socket, 1, relayKinds);
        LogUtils.v(() => "$relay connection initialized");
        _setConnectStatus(relay, 1);
        // #region agent log
        _connectDebugLog('B', 'connect:SUCCESS', 'Connection established', {'relay': relay});
        // #endregion
      }
    } catch (_) {
      _onDisconnected(relay, relayKind);
    } finally {
      _activeConnectionCount--;
      _connectDebugLog('B', 'connect:DONE_INTERNAL', 'Connection attempt finished', {'relay': relay, 'activeConns': _activeConnectionCount, 'queueSize': _connectionQueue.length});
      // Process next queued connection
      _processConnectionQueue();
    }
  }
  
  void _processConnectionQueue() {
    if (_connectionQueue.isEmpty || _activeConnectionCount >= MAX_CONCURRENT_CONNECTIONS) return;
    
    final pending = _connectionQueue.removeAt(0);
    _connectDebugLog('B', 'connect:DEQUEUE', 'Processing queued connection', {'relay': pending.relay, 'remainingQueue': _connectionQueue.length});
    
    final relayKinds = webSockets[pending.relay]?.relayKinds ?? [pending.relayKind];
    
    // On Linux, delay before starting the next connection to yield event loop time
    // to GLib idle callbacks (Flutter frame rendering). Without this delay,
    // connection completions chain immediately into the next connection,
    // leaving no gap for lower-priority idle sources to execute.
    void startConnection() {
      _doConnectInternal(pending.relay, pending.relayKind, relayKinds).then((_) {
        if (!pending.completer.isCompleted) pending.completer.complete();
      }).catchError((e) {
        if (!pending.completer.isCompleted) pending.completer.complete();
      });
    }
    
    if (Platform.isLinux) {
      Future.delayed(Duration(milliseconds: 100), startConnection);
    } else {
      startConnection();
    }
  }
  // #endregion

  Future<bool> connectRelays(List<String> relays, {RelayKind relayKind = RelayKind.general}) async {
    // #region agent log
    _connectDebugLog('B', 'connectRelays:ENTER', 'Batch connect request', {'relayCount': relays.length, 'kind': relayKind.name, 'relays': relays.take(5).toList()});
    // #endregion
    final completer = Completer<bool>();
    if (relays.isEmpty && !completer.isCompleted) completer.complete(true);
    if (relayKind == RelayKind.temp) {
      // timeout for temp relays
      Timer(Duration(seconds: 10), () {
        if (!completer.isCompleted) {
          // #region agent log
          _connectDebugLog('B', 'connectRelays:TIMEOUT', 'Temp relay timeout reached', {'relayCount': relays.length});
          // #endregion
          completer.complete(false);
          closeConnects(relays, relayKind);
        }
      });
    }
    for (String relay in relays) {
      connect(relay, relayKind: relayKind).then((value) {
        if (!completer.isCompleted) completer.complete(true);
      });
    }
    return completer.future;
  }

  Future closeConnects(List<String> relays, RelayKind relayKind) async {
    await Future.forEach(relays, (relay) async {
      webSockets[relay]?.relayKinds.removeWhere((e) => (e == RelayKind.temp || e == relayKind));
      if (webSockets[relay]?.relayKinds.isEmpty == true) {
        await closeConnect(relay);
      }
    });
  }

  Future closeTempConnects(List<String> relays) async {
    await closeConnects(relays, RelayKind.temp);
  }

  Future closeAllConnects() async {
    await Future.forEach(List.from(webSockets.keys), (relay) async {
      await closeConnect(relay);
    });
    sendsMap.clear();
    requestsMap.clear();
    auths.clear();
    eventCheckerFutures.clear();
    subscriptionsWaitingQueue.clear();
  }

  Future closeConnect(String relay) async {
    LogUtils.v(() => 'closeConnect ${webSockets[relay]?.socket}');
    final socket = webSockets[relay]?.socket;
    webSockets.remove(relay);
    await socket?.close();
  }

  String addSubscription(List<Filter> filters,
      {EventCallBack? eventCallBack,
      EOSECallBack? eoseCallBack,
      List<String>? relays,
      List<RelayKind> relayKinds = const [RelayKind.general, RelayKind.circleRelay],
      bool closeSubscription = true}) {
    Map<String, List<Filter>> result = {};
    List<String> rs = [];
    if (relays != null) {
      rs = List.from(relays
          .where((relay) =>
              relay.isNotEmpty && (relay.startsWith('ws://') || relay.startsWith('wss://')))
          .toList());
    }
    List<String> subscriptionRelays =
        rs.isNotEmpty == true ? rs : Connect.sharedInstance.relays(relayKinds: relayKinds);
    if (subscriptionRelays.isEmpty) {
      eoseCallBack?.call('', OKEvent('', false, 'no relays connected'), '', []);
      return '';
    }
    for (var relay in subscriptionRelays) {
      result[relay] = filters;
    }
    return addSubscriptions(result,
        eventCallBack: eventCallBack,
        eoseCallBack: eoseCallBack,
        closeSubscription: closeSubscription);
  }

  String addSubscriptions(Map<String, List<Filter>> filters,
      {EventCallBack? eventCallBack, EOSECallBack? eoseCallBack, bool closeSubscription = true}) {
    /// Create a subscription message request with one or many filters
    String requestsId = generate64RandomHexChars();
    for (String relay in filters.keys) {
      Request requestWithFilter = Request(requestsId, filters[relay]!);
      String subscriptionString = requestWithFilter.serialize();

      /// add request to request map
      Requests requests = Requests(requestsId, filters.keys.toList(), 0, {}, eventCallBack,
          eoseCallBack, subscriptionString, closeSubscription);
      requests.subscriptions[relay] = requestWithFilter.subscriptionId;
      requestsMap[requestWithFilter.subscriptionId + relay] = requests;

      /// Send a request message to the WebSocket server
      _addSubscriptionToQueue(requestsId, relay);

      LogUtils.v(() => '$subscriptionString, $relay');
    }
    return requestsId;
  }

  void _addSubscriptionToQueue(String subscriptionId, String relay) {
    var waitingQueue = subscriptionsWaitingQueue[relay] ?? [];
    if (!waitingQueue.contains(subscriptionId)) {
      waitingQueue.add(subscriptionId);
      subscriptionsWaitingQueue[relay] = waitingQueue;
    }
    _sendSubscription(relay);
  }

  void _sendSubscription(String relay) {
    var sendingQueue = 0;
    for (var key in requestsMap.keys) {
      if (key.contains(relay) &&
          requestsMap[key]!.relays.contains(relay) &&
          requestsMap[key]!.requestTime > 0) {
        ++sendingQueue;
      }
    }
    var waitingQueue = subscriptionsWaitingQueue[relay] ?? [];

    if (sendingQueue < MAX_SUBSCRIPTIONS_COUNT && waitingQueue.isNotEmpty) {
      String subscriptionId = waitingQueue.removeAt(0);
      var request = requestsMap[subscriptionId + relay];
      if (request != null) {
        requestsMap[subscriptionId + relay]!.requestTime = DateTime.now().millisecondsSinceEpoch;
        _send(request.subscriptionString, toRelays: [relay]);
      }
    } else {
      LogUtils.v(
          () => 'sendingQueue: ${sendingQueue}, waitingQueue: ${waitingQueue.length}, $relay');
    }
  }

  Future _closeSubscription(String subscriptionId, String relay) async {
    LogUtils.v(() => 'send ${Close(subscriptionId).serialize()}, $relay');
    if (subscriptionId.isNotEmpty) {
      _send(Close(subscriptionId).serialize(), toRelays: [relay]);
      // remove the mapping
      requestsMap.remove(subscriptionId + relay);
      _sendSubscription(relay);
    }
  }

  Future closeRequests(String requestId, {String? relay}) async {
    Iterable<String> requestsMapKeys = List<String>.from(requestsMap.keys);

    // Find all entries with matching requestId (there may be multiple entries, one per relay)
    List<MapEntry<String, Requests>> matchingEntries = [];
    for (var key in requestsMapKeys) {
      var requests = requestsMap[key];
      if (requests!.requestId == requestId) {
        matchingEntries.add(MapEntry(key, requests));
      }
    }
    
    if (matchingEntries.isEmpty) {
      return;
    }
    
    // Close subscriptions for all matching entries
    for (var entry in matchingEntries) {
      var requests = entry.value;
      
      if (relay != null) {
        // Close specific relay subscription if it exists in this entry
        if (requests.subscriptions.containsKey(relay) && requests.subscriptions[relay] != null) {
          await _closeSubscription(requests.subscriptions[relay]!, relay);
        }
      } else {
        // Close all subscriptions for this entry
        for (var subscriptionRelay in requests.subscriptions.keys) {
          if (requests.subscriptions[subscriptionRelay] != null) {
            await _closeSubscription(requests.subscriptions[subscriptionRelay]!, subscriptionRelay);
          } 
        }
      }
    }
  }

  /// send an event to relay/relays
  void sendEvent(Event event,
      {OKCallBack? sendCallBack,
      List<String>? toRelays,
      List<RelayKind> relayKinds = const [
        RelayKind.general,
        RelayKind.outbox,
        RelayKind.circleRelay
      ]}) {
    String eventString = event.serialize();
    List<String> rs;
    bool useExplicitRelays = false;
    
    if (toRelays != null && toRelays.isNotEmpty) {
      // User explicitly provided relay list
      rs = List.from(toRelays);
      useExplicitRelays = true;
    } else {
      // Get relays based on relayKinds
      rs = relays(relayKinds: relayKinds);
      // Only add circleRelay if it's included in the requested relayKinds
      // This allows users to explicitly choose which relay types to use
      if (relayKinds.contains(RelayKind.circleRelay)) {
        rs.addAll(relays(relayKinds: [RelayKind.circleRelay]));
      }
      // If relayKinds is not the default (contains only general, outbox, circleRelay),
      // then user explicitly chose, so don't fallback to all relays
      final defaultKinds = [RelayKind.general, RelayKind.outbox, RelayKind.circleRelay];
      useExplicitRelays = !_listEquals(relayKinds, defaultKinds);
    }
    
    LogUtils.v(() => 'send event toRelays: ${jsonEncode(rs)}, relayKinds: ${relayKinds.map((e) => e.name)}, useExplicitRelays: $useExplicitRelays');
    Sends sends = Sends(generate64RandomHexChars(), rs, DateTime.now().millisecondsSinceEpoch,
        event.id, sendCallBack, eventString);
    sendsMap[event.id] = sends;
    // If user explicitly chose relayKinds but no relays are available, don't fallback to all relays
    _send(eventString, toRelays: rs, eventId: event.id, allowFallbackToAll: !useExplicitRelays);
  }
  
  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _send(String data, {List<String>? toRelays, String? eventId, String? subscriptionId, bool allowFallbackToAll = true}) {
    if (toRelays != null) {
      // If toRelays is an empty list and allowFallbackToAll is false, don't send to any relay
      if (toRelays.isEmpty && !allowFallbackToAll) {
        if (eventId != null) {
          _handleOk(OKEvent(eventId, false, 'no relays available'), '');
        }
        return;
      }
      
      if (toRelays.isNotEmpty) {
        toRelays = Set.from(toRelays).cast<String>().toList();
        for (var relay in toRelays) {
          if (webSockets.containsKey(relay)) {
            var socket = webSockets[relay]?.socket;
            if (webSockets[relay]?.connectStatus == 1 && socket != null) {
              socket.add(data);
            } else if (eventId != null) {
              _handleOk(OKEvent(eventId, false, 'not connect to relay'), relay);
            } else if (subscriptionId != null) {
              _handleCLOSED(Closed(subscriptionId), relay);
            }
          } else if (eventId != null) {
            _handleOk(OKEvent(eventId, false, 'not connect to relay'), relay);
          } else if (subscriptionId != null) {
            _handleCLOSED(Closed(subscriptionId), relay);
          }
        }
        return;
      }
    }
    
    // Fallback to all connected relays only if allowFallbackToAll is true
    if (allowFallbackToAll) {
      bool hasConnectedRelay = false;
      webSockets.forEach((url, socket) {
        if (webSockets[url]?.connectStatus == 1 && socket.socket != null) {
          socket.socket?.add(data);
          hasConnectedRelay = true;
        } else if (eventId != null) {
          _handleOk(OKEvent(eventId, false, 'not connect to relay'), url);
        } else if (subscriptionId != null) {
          _handleCLOSED(Closed(subscriptionId), url);
        }
      });
      // If no connected relays and eventId is set, handle as failure
      if (!hasConnectedRelay && eventId != null && webSockets.isEmpty) {
        _handleOk(OKEvent(eventId, false, 'no relays available'), '');
      }
    } else if (eventId != null) {
      _handleOk(OKEvent(eventId, false, 'no relays available'), '');
    }
  }

  static Future<Message> _deserializeMessage(String message) async {
    return await Message.deserialize(message);
  }

  Future<void> _handleMessage(String message, String relay) async {
    var m = await ThreadPoolManager.sharedInstance.runOtherTask(() => _deserializeMessage(message));
    switch (m.type) {
      case "EVENT":
        _handleEvent(m.message, relay);
        break;
      case "EOSE":
        _handleEOSE(m.message, relay, false);
        break;
      case "CLOSED":
        _handleCLOSED(m.message, relay);
        break;
      case "NOTICE":
      case "NOTIFY":
        _handleNotice(m.message, relay);
        break;
      case "OK":
        _handleOk(m.message, relay);
        break;
      case "AUTH":
        _handleAuth(m.message, relay);
        break;
      default:
        LogUtils.v(() => 'Received message not supported: $message');
        break;
    }
  }

  // On Linux, event.isValid() calls bip340.verify() + SHA256 synchronously on
  // the main thread. For each incoming event, this blocks the main thread for
  // ~1-5ms. When many events arrive (100+), this can block for 500ms+.
  // Move the CPU-intensive crypto to the algorithm isolate on Linux.
  static Future<bool> _isValidEventInIsolate(Map<String, dynamic> params) async {
    final pubkey = params['pubkey'] as String;
    final id = params['id'] as String;
    final sig = params['sig'] as String;
    final createdAt = params['createdAt'] as int;
    final kind = params['kind'] as int;
    final tags = (params['tags'] as List)
        .map((t) => (t as List).map((s) => s.toString()).toList())
        .toList();
    final content = params['content'] as String;

    final verifyId = Event.processEventId(pubkey, createdAt, kind, tags, content);
    if (createdAt.toString().length == 10 && id == verifyId) {
      return bip340.verify(pubkey, id, sig);
    }
    return false;
  }

  Future<bool> _checkValidEvent(Event event, String relay) async {
    String? subscriptionId = event.subscriptionId;
    if (subscriptionId != null) {
      String requestsMapKey = subscriptionId + relay;
      if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
        // reset requestTime
        requestsMap[requestsMapKey]!.requestTime = DateTime.now().millisecondsSinceEpoch;
        EventCallBack? callBack = requestsMap[requestsMapKey]!.eventCallBack;
        if (callBack != null) {
          EventCache.sharedInstance.receiveEvent(event, relay);
          // check sign - on Linux, move crypto to isolate to avoid blocking main thread
          bool isValid;
          if (Platform.isLinux) {
            isValid = await ThreadPoolManager.sharedInstance.runAlgorithmTask(
              () => _isValidEventInIsolate({
                'pubkey': event.pubkey,
                'id': event.id,
                'sig': event.sig,
                'createdAt': event.createdAt,
                'kind': event.kind,
                'tags': event.tags,
                'content': event.content,
              })
            ) as bool;
          } else {
            isValid = await event.isValid();
          }
          if (!isValid) {
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
    LogUtils.v(() => 'Received event, subscriptionId: ${event.subscriptionId}, ${event.toJson()}');
    if (EventCache.sharedInstance.cacheIds.contains(event.id)) {
      return;
    }
    // ignore the expired event
    if (Nip40.expired(event)) {
      EventCache.sharedInstance.receiveEvent(event, relay);
      return;
    }

    Future<bool> future = _checkValidEvent(event, relay);
    if (event.subscriptionId != null && event.subscriptionId!.isNotEmpty) {
      eventCheckerFutures[event.subscriptionId! + relay] ??= [];
      eventCheckerFutures[event.subscriptionId! + relay]?.add(future);
    }
  }

  Future<void> _handleEOSE(String eose, String relay, bool timeout) async {
    LogUtils.v(() => 'receive EOSE: $eose, $relay, timeout: $timeout');
    String subscriptionId = jsonDecode(eose)[0];
    String requestsMapKey = subscriptionId + relay;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      if (eventCheckerFutures.containsKey(requestsMapKey)) {
        // #region agent log
        final futureCount = eventCheckerFutures[requestsMapKey]!.length;
        final eoseStart = DateTime.now().millisecondsSinceEpoch;
        // #endregion
        await Future.wait(eventCheckerFutures[requestsMapKey]!);
        // #region agent log
        final eoseMs = DateTime.now().millisecondsSinceEpoch - eoseStart;
        if (Platform.isLinux && eoseMs > 5) {
          try { File('/Users/bear/Desktop/jenkins/.cursor/debug.log').writeAsStringSync('{"sessionId":"debug-session","hypothesisId":"E","location":"connect.dart:_handleEOSE","message":"Future.wait slow","data":{"relay":"$relay","futureCount":$futureCount,"waitMs":$eoseMs,"timeout":$timeout},"timestamp":${DateTime.now().millisecondsSinceEpoch}}\n', mode: FileMode.append); } catch(_) {}
          debugPrint('[EOSE_WAIT] Future.wait took ${eoseMs}ms for $futureCount futures, relay=$relay timeout=$timeout');
        }
        // #endregion
        eventCheckerFutures.remove(requestsMapKey);
      }
      _removeRequestsMapRelay(subscriptionId, relay, timeout);
    }
  }

  void _handleCLOSED(Closed closed, String relay) {
    LogUtils.v(() => 'receive closed: ${closed.serialize()}, $relay');
    String subscriptionId = closed.subscriptionId;
    String requestsMapKey = subscriptionId + relay;
    if (subscriptionId.isNotEmpty && requestsMap.containsKey(requestsMapKey)) {
      // check auth
      if (Nip42.authRequired(closed.message)) {
        String subscriptionString = requestsMap[requestsMapKey]!.subscriptionString;
        if (auths[relay]?.resendDatas.contains(subscriptionString) == false) {
          auths[relay]?.resendDatas.add(subscriptionString);
        }
        _sendAuth(relay);
        return;
      }
      _removeRequestsMapRelay(subscriptionId, relay, true);
    }
  }

  void _handleNotice(String notice, String relay) {
    LogUtils.v(() => 'receive notice: $notice, $relay');
    String n = jsonDecode(notice)[0];

    List<String> requestsMapKeys =
        requestsMap.keys.where((element) => element.contains(relay)).toList();
    for (var requestsMapKey in requestsMapKeys) {
      _removeRequestsMapRelay(requestsMapKey.replaceAll(relay, ''), relay, true);
    }

    noticeCallBack?.call(n, relay);
  }

  Future<void> _handleOk(OKEvent ok, String relay) async {
    LogUtils.v(() => 'receive ok: ${ok.serialize()}, $relay');
    // check auth response
    if (auths[relay]?.eventId == ok.eventId) {
      if (ok.status) {
        for (var data in auths[relay]?.resendDatas ?? []) {
          LogUtils.v(() => 're-send: $data');
          _send(data, toRelays: [relay]);
        }
      }
      auths.remove(relay);
      return;
    }
    
    // Update eventSendStatus in EventDBISAR
    if (ok.eventId.isNotEmpty) {
      EventCache.sharedInstance.updateEventSendStatus(ok.eventId, relay, ok.status, ok.message);
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
      // callback
      if (sendsMap[ok.eventId]!.okCallBack != null) {
        var relays = sendsMap[ok.eventId]!.relays;
        relays.remove(relay);
        // If event succeeded, call callback immediately
        // If event failed, call callback only when all relays have been tried (relays.isEmpty)
        // This ensures callback is always called, even if all relays fail
        if (ok.status || relays.isEmpty) {
          sendsMap[ok.eventId]!.okCallBack!(ok, relay);
          sendsMap.remove(ok.eventId);
        } else if (!ok.status && ok.eventId.isEmpty) {
          List<String> requestsMapKeys =
              requestsMap.keys.where((element) => element.contains(relay)).toList();
          for (var requestsMapKey in requestsMapKeys) {
            _removeRequestsMapRelay(requestsMapKey.replaceAll(relay, ''), relay, true);
          }
        }
      } else {
        var relays = sendsMap[ok.eventId]!.relays;
        relays.remove(relay);
        if (relays.isEmpty) sendsMap.remove(ok.eventId);
      }
    }
  }

  void _handleAuth(Auth auth, String relay) {
    LogUtils.v(() => 'receive auth: ${auth.challenge}');
    if (!auths.containsKey(relay)) {
      auths[relay] = AuthData(auth.challenge, '', []);
    } else if (auths[relay]?.challenge != auth.challenge) {
      auths[relay]?.challenge = auth.challenge;
      auths[relay]?.eventId = '';
    }
  }

  void _removeRequestsMapRelay(String subscriptionId, String removeRelay, bool error) {
    var requestsMapKey = subscriptionId + removeRelay;
    var request = requestsMap[requestsMapKey];
    if (request == null) return;
    request.relays.remove(removeRelay);
    // remove others relay
    for (var r in requestsMap.values) {
      if (r.requestId == request.requestId) {
        r.relays.remove(removeRelay);
      }
    }
    // all relays have EOSE
    EOSECallBack? callBack = request.eoseCallBack;
    OKEvent ok = OKEvent(subscriptionId, !error, '');
    if (callBack != null) callBack(subscriptionId, ok, removeRelay, request.relays);
    requestsMap[requestsMapKey]?.eoseCallBack = null;
    if (request.closeSubscription) _closeSubscription(subscriptionId, removeRelay);
  }

  Future<void> _sendAuth(String relay) async {
    String? challenge = auths[relay]?.challenge;
    if (challenge == null || challenge.isEmpty) return;
    String? eventId = auths[relay]?.eventId;
    if (eventId?.isNotEmpty == true) return;
    auths[relay]!.eventId = 'sending...';
    Event event = await Nip42.encode(challenge, relay, Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    var authJson = Nip42.authString(event);
    auths[relay]!.eventId = event.id;
    LogUtils.v(() => 'send auth: $authJson');
    _send(authJson, toRelays: [relay]);
  }

  Future<void> _reConnectToRelay(String relay, RelayKind relayKind) async {
    // Guard: skip if already connecting (status 0) or already in the queue.
    // This prevents reconnection storms when multiple disconnect signals
    // (socket.done, onDone, onError) fire for the same relay.
    final currentStatus = webSockets[relay]?.connectStatus;
    if (currentStatus == 0) return; // already connecting
    if (_connectionQueue.any((p) => p.relay == relay)) return; // already queued
    
    // #region agent log
    if (Platform.isLinux) {
      final now = DateTime.now();
      final ts = '${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}.${now.millisecond.toString().padLeft(3,'0')}';
      try { File('/Users/bear/Desktop/jenkins/.cursor/debug.log').writeAsStringSync('{"sessionId":"debug-session","hypothesisId":"B","location":"connect.dart:_reConnectToRelay","message":"reconnect triggered","data":{"relay":"$relay","relayKind":"${relayKind.name}"},"timestamp":${now.millisecondsSinceEpoch}}\n', mode: FileMode.append); } catch(_) {}
      debugPrint('[RECONNECT][$ts] _reConnectToRelay: relay=$relay kind=${relayKind.name}');
    }
    // #endregion
    _setConnectStatus(relay, 3); // closed
    await Future.delayed(Duration(milliseconds: 3000));
    if (webSockets.containsKey(relay)) {
      await connect(relay, relayKind: relayKind);
    }
  }

  void _listenEvent(WebSocket socket, String relay, RelayKind relayKind) {
    socket.listen((message) async {
      await _handleMessage(message, relay);
    }, onDone: () async {
      LogUtils.v(() => "connect aborted");
      await _reConnectToRelay(relay, relayKind);
    }, onError: (e) async {
      LogUtils.v(() => 'Server error: $e');
      await _reConnectToRelay(relay, relayKind);
    });
  }

  Future _connectWs(String relay, [int retryCount = 0]) async {
    // #region agent log - check retry limit before attempting
    _relayFailures[relay] ??= _RelayFailureInfo();
    final failureInfo = _relayFailures[relay]!;
    if (failureInfo.shouldSkip(MAX_RETRY_COUNT, RETRY_BACKOFF_SECONDS)) {
      _connectDebugLog('C', '_connectWs:SKIP_BACKOFF', 'Skipping due to retry backoff', {
        'relay': relay, 
        'retryCount': failureInfo.retryCount,
        'backoffSecondsRemaining': RETRY_BACKOFF_SECONDS - ((DateTime.now().millisecondsSinceEpoch - failureInfo.lastFailTimeMs) ~/ 1000)
      });
      _setConnectStatus(relay, 3); // closed
      return;
    }
    _connectDebugLog('C', '_connectWs:ENTER', 'Connection attempt', {'relay': relay, 'retryCount': retryCount, 'totalFailures': failureInfo.retryCount});
    // #endregion
    try {
      _setConnectStatus(relay, 0); // connecting
      final socket = await _connectWsSetting(relay);
      // #region agent log - reset failure count on success
      failureInfo.reset();
      // #endregion
      return socket;
    } catch (e) {
      LogUtils.v(() => "Error! can not connect WS connectWs $e relay:$relay");
      _setConnectStatus(relay, 3); // closed
      
      // #region agent log - record failure
      failureInfo.recordFailure();
      _connectDebugLog('C', '_connectWs:FAIL', 'Connection failed', {'relay': relay, 'totalFailures': failureInfo.retryCount, 'error': e.toString().substring(0, (e.toString().length > 80 ? 80 : e.toString().length))});
      // #endregion

      // Check if error is "was not upgraded to websocket, HTTP status code: 200"
      // If so, don't retry connection
      String errorStr = e.toString();
      if (errorStr.contains('was not upgraded to websocket') && 
          errorStr.contains('HTTP status code: 200')) {
        LogUtils.v(() => "WebSocket upgrade failed with HTTP 200, skipping retry for relay:$relay");
        return;
      }
      
      // #region agent log - check if max retries reached
      if (failureInfo.retryCount >= MAX_RETRY_COUNT) {
        _connectDebugLog('C', '_connectWs:MAX_RETRIES', 'Max retries reached, entering backoff', {'relay': relay, 'totalFailures': failureInfo.retryCount, 'backoffSeconds': RETRY_BACKOFF_SECONDS});
        return;
      }
      // #endregion

      List<RelayKind>? relayKinds = webSockets[relay]?.relayKinds;
      bool hasNonTempKind = relayKinds?.any((kind) => kind != RelayKind.temp) ?? false;
      if (hasNonTempKind) {
        // Shorter retry wait on Linux to finish failed relays faster and reduce
        // total I/O event loop occupation time.
        final retryWaitMs = Platform.isLinux ? 1500 : 3000;
        // #region agent log
        _connectDebugLog('C', '_connectWs:RETRY_WAIT', 'Waiting before retry', {'relay': relay, 'retryCount': retryCount, 'waitMs': retryWaitMs});
        // #endregion
        await Future.delayed(Duration(milliseconds: retryWaitMs));
        if (webSockets.containsKey(relay)) {
          return await _connectWs(relay, retryCount + 1);
        }
      } else {
        // #region agent log
        _connectDebugLog('C', '_connectWs:NO_RETRY', 'Temp relay, not retrying', {'relay': relay});
        // #endregion
      }
    }
  }

  // #region agent log - connection timeout constant
  // Shorter timeout on Linux to reduce GLib event loop pressure from I/O callbacks.
  static final int CONNECT_TIMEOUT_SECONDS = Platform.isLinux ? 3 : 5;
  // #endregion

  Future _connectWsSetting(String relay) async {
    String? host = Config.sharedInstance.hostConfig[relay];
    if (host != null && host.isNotEmpty) {
      relay = host;
    }

    // #region agent log
    final startTime = DateTime.now().millisecondsSinceEpoch;
    _connectDebugLog('A', 'connectWsSetting:BEFORE', 'WebSocket.connect starting', {'relay': relay, 'timeoutSeconds': CONNECT_TIMEOUT_SECONDS});
    // #endregion
    
    // Use a dedicated HttpClient with connectionTimeout instead of .timeout().
    //
    // .timeout() problem: When .timeout() fires, only the Dart Future is abandoned.
    // The underlying DNS/TCP/TLS operations continue running as "orphan" connections,
    // generating I/O events on the GLib main loop. Over time, orphans accumulate.
    //
    // HttpClient.connectionTimeout: When the timeout fires, HttpClient calls
    // ConnectionTask.cancel() which properly closes the underlying socket,
    // reducing orphaned I/O operations.
    //
    // We also wrap with .timeout() as a safety net in case connectionTimeout
    // doesn't fire (e.g., during WebSocket upgrade phase after TCP connect).
    final httpClient = HttpClient();
    httpClient.connectionTimeout = Duration(seconds: CONNECT_TIMEOUT_SECONDS);
    
    try {
      final socket = await WebSocket.connect(relay, customClient: httpClient).timeout(
        Duration(seconds: CONNECT_TIMEOUT_SECONDS + 2), // safety net: slightly longer
        onTimeout: () {
          // Force close the HttpClient if the safety timeout fires
          try { httpClient.close(force: true); } catch (_) {}
          throw TimeoutException('WebSocket.connect timed out after ${CONNECT_TIMEOUT_SECONDS}s', Duration(seconds: CONNECT_TIMEOUT_SECONDS));
        },
      );
      // #region agent log
      final duration = DateTime.now().millisecondsSinceEpoch - startTime;
      _connectDebugLog('A', 'connectWsSetting:SUCCESS', 'WebSocket.connect completed', {'relay': relay, 'durationMs': duration});
      // #endregion
      return socket;
    } catch (e) {
      // #region agent log
      final closeStart = DateTime.now().millisecondsSinceEpoch;
      // #endregion
      // Close the HttpClient to clean up any pending connection resources.
      // Use force:false to avoid unhandled SocketExceptions.
      try { httpClient.close(); } catch (_) {}
      // #region agent log
      final closeMs = DateTime.now().millisecondsSinceEpoch - closeStart;
      final duration = DateTime.now().millisecondsSinceEpoch - startTime;
      if (Platform.isLinux && closeMs > 1) {
        try { File('/Users/bear/Desktop/jenkins/.cursor/debug.log').writeAsStringSync('{"sessionId":"debug-session","hypothesisId":"D","location":"connect.dart:_connectWsSetting","message":"httpClient.close slow","data":{"relay":"$relay","closeMs":$closeMs},"timestamp":${DateTime.now().millisecondsSinceEpoch}}\n', mode: FileMode.append); } catch(_) {}
        debugPrint('[CLOSE_TIMING] httpClient.close() took ${closeMs}ms for $relay');
      }
      _connectDebugLog('A', 'connectWsSetting:ERROR', 'WebSocket.connect failed', {'relay': relay, 'durationMs': duration, 'error': e.toString().substring(0, (e.toString().length > 120 ? 120 : e.toString().length))});
      // #endregion
      rethrow;
    }
  }

  Future<void> _onDisconnected(String relay, RelayKind relayKind) async {
    LogUtils.v(() => "_onDisconnected");
    return await _reConnectToRelay(relay, relayKind);
  }

  /// Wait for a relay connection to be established
  /// Returns true if connection succeeds, false if connection fails
  /// Either relay or relayKind must be provided
  Future<bool> waitForRelayConnection({
    String? relay,
    RelayKind? relayKind,
  }) async {
    // Determine relay URL and relayKind
    String? targetRelay = relay;
    RelayKind? targetRelayKind = relayKind;

    // If relay is not provided, get it from relayKind
    if (targetRelay == null || targetRelay.isEmpty) {
      if (targetRelayKind == null) {
        return false; // Both relay and relayKind are null
      }

      if (targetRelayKind == RelayKind.circleRelay) {
        final relays = this.relays(relayKinds: [RelayKind.circleRelay]);
        if (relays.isEmpty) return false;
        targetRelay = relays.first;
      } else {
        // For other relay kinds, get from connected relays
        final connectedRelays = this.relays(relayKinds: [targetRelayKind]);
        if (connectedRelays.isEmpty) return false;
        targetRelay = connectedRelays.first;
      }
    }

    // At this point, targetRelay should not be null or empty
    if (targetRelay.isEmpty) return false;

    // If relayKind is not provided, try to infer from existing connection
    if (targetRelayKind == null) {
      final webSocket = webSockets[targetRelay];
      targetRelayKind = webSocket?.relayKinds.isNotEmpty == true
          ? webSocket!.relayKinds.first
          : RelayKind.general;
    }

    // Check if already connected
    // connectStatus: 0=connecting, 1=open, 2=closing, 3=closed
    final webSocket = webSockets[targetRelay];
    if (webSocket != null &&
        webSocket.connectStatus == 1 &&
        webSocket.relayKinds.contains(targetRelayKind)) {
      return true;
    }

    // If relay is not in webSockets or not connecting, start connection
    if (webSocket == null || webSocket.connectStatus == 3) {
      connect(targetRelay, relayKind: targetRelayKind);
    }

    // Create completer to wait for connection
    final completer = Completer<bool>();
    ConnectStatusCallBack? connectionListener;

    // Setup connection status listener
    connectionListener = (String statusRelay, int status, List<RelayKind> relayKinds) {
      if (statusRelay != targetRelay) return;

      // Connection succeeded (status 1 = open)
      if (status == 1 && relayKinds.contains(targetRelayKind)) {
        removeConnectStatusListener(connectionListener!);
        if (!completer.isCompleted) {
          completer.complete(true);
        }
        return;
      }

      // Connection failed (status 3 = closed and no longer in webSockets, meaning no retry)
      if (status == 3 && !webSockets.containsKey(targetRelay)) {
        removeConnectStatusListener(connectionListener!);
        if (!completer.isCompleted) {
          completer.complete(false);
        }
        return;
      }
    };

    // Add listener to wait for connection
    addConnectStatusListener(connectionListener);

    // Wait for connection result
    return completer.future;
  }
}