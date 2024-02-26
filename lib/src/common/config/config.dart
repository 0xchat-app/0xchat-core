/// 0xchat config based on relay events
/// 1.DNS configs 2.Discovery configs

import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class Config {
  /// singleton
  Config._internal();

  factory Config() => sharedInstance;
  static final Config sharedInstance = Config._internal();

  String _configRequestsId = '';
  Map<String, ConfigDB> configs = {};
  final String _serverPubkey = '';
  // config host
  Map<String, String> host = {};

  void initConfig() {
    _loadConfig();
    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        _loadConfigFromRelay(relay: relay);
      }
    });
  }

  Future<void> _loadConfig() async {
    await _loadConfigFromDB();
    _loadConfigFromRelay();
  }

  Future<void> _loadConfigFromDB() async {
    List<Object?> maps = await DB.sharedInstance.objects<ConfigDB>();
    configs = {for (var configDB in maps) (configDB as ConfigDB).d: configDB};
    _setHostConfig();
  }

  void _loadConfigFromRelay({String? relay}) {
    if (_configRequestsId.isNotEmpty) {
      Connect.sharedInstance.closeRequests(_configRequestsId);
    }

    Map<String, List<Filter>> subscriptions = {};
    Filter f = Filter(kinds: [30078], authors: [_serverPubkey]);

    if (relay == null) {
      for (var r in Connect.sharedInstance.relays()) {
        subscriptions[r] = [f];
      }
    } else {
      subscriptions[relay] = [f];
    }

    _configRequestsId = Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) {
      Relays.sharedInstance.setCommonMessageUntil(event.createdAt, relay);
      Relays.sharedInstance.setCommonMessageSince(event.createdAt, relay);
      switch (event.kind) {
        case 30078:
          _handleAppData(event);
          break;
        default:
          print('unhandled message $event');
          break;
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      if (unCompletedRelays.isEmpty) {
        Connect.sharedInstance.closeRequests(requestId);
      }
    });
  }

  Future<void> _handleAppData(Event event) async {
    AppData appData = Nip78.decodeAppData(event);
    if (appData.d == null) return;
    ConfigDB configDB = ConfigDB(
        d: appData.d ?? '',
        eventId: event.id,
        time: appData.createAt,
        configJson: appData.content);
    int result = await DB.sharedInstance.insert<ConfigDB>(configDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result > 0) {
      configs[configDB.d] = configDB;
      _setHostConfig();
    }
  }

  void _setHostConfig(){
    String? json = configs['']?.configJson;
    if(json != null){
      Map map = jsonDecode(json);
      String? ip = map['ip'];
      if(ip != null) host['wss://relay.0xchat.com'] = ip;
    }
  }
}
