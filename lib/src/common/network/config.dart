/// 0xchat config based on relay events
/// 1.DNS configs 2.Discovery configs
///
import 'dart:async';
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
  final Map<String, String> _hostMap = {};
  final String _serverPubkey = '';
  final String _configD = '0xchat-config';

  void initConfig(){
    _loadConfig();
    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        _loadConfig(relay: relay);
      }
    });
  }

  void _loadConfig({String? relay}){
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
        });
  }

  void _handleAppData(Event event){
    AppData appData = Nip78.decodeAppData(event);
    if(appData.d != null && appData.d == _configD){
      // todo: config json
      String config = appData.content;

    }
  }

  String? getHost(String relay){
    return _hostMap[relay];
  }
}