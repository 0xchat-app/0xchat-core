/// 0xchat config based on relay events
/// 1.DNS configs 2.Discovery configs

import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class Config {
  /// singleton
  Config._internal();

  factory Config() => sharedInstance;
  static final Config sharedInstance = Config._internal();

  String _configRequestsId = '';
  Map<String, ConfigDB> configs = {};

  // recommendChannels config
  List<String> recommendChannels = [
    'db0c7f767e730c71e008ca674094fd6446abc4404a5a04197f5516779f627752',
    '25e5c82273a271cb1a840d0060391a0bf4965cafeb029d5ab55350b418953fbb',
    '40b50ef7e5c83e12b106e45c4646a07c722e08676455cd6e796e7ae1c82ac5f5'
  ];
  // host config
  Map<String, String> hostConfig = {
    "wss://relay.0xchat.com": "wss://52.76.210.159",
    "www.0xchat.com": "54.179.158.105:9602",
    "mint.0xchat.com": "13.38.85.175:3337",
    // "wss://groups.0xchat.com": "ws://54.179.158.105:5577",
  };
  final String _serverPubkey =
      '093dff31a87bbf838c54fd39ff755e72b38bd6b7975c670c0f2633fa7c54ddd0';
  final String configD = '0xchat-config';
  final String wssHost = 'wss://relay.0xchat.com';
  final String httpHost = 'www.0xchat.com';
  final String mintHost = 'mint.0xchat.com';
  // final String relayGroupHost = 'wss://groups.0xchat.com';

  Future<void> initConfig() async {
    // subscript friend requests
    Connect.sharedInstance
        .addConnectStatusListener((relay, status, relayKind) async {
      if (status == 1 &&
          Account.sharedInstance.me != null &&
          relayKind == RelayKind.general) {
        _loadConfigFromRelay(relay: relay);
      }
    });
    await _loadConfig();
  }

  Future<void> _loadConfig() async {
    await _loadConfigFromDB();
    _loadConfigFromRelay();
  }

  Future<void> _loadConfigFromDB() async {
    List<Object?> maps = await DB.sharedInstance.objects<ConfigDB>();
    configs = {for (var configDB in maps) (configDB as ConfigDB).d: configDB};
    _setConfig();
  }

  void _loadConfigFromRelay({String? relay}) {
    if (_configRequestsId.isNotEmpty) {
      Connect.sharedInstance.closeRequests(_configRequestsId);
    }

    Map<String, List<Filter>> subscriptions = {};
    Filter f = Filter(kinds: [30078], d: [configD], authors: [_serverPubkey]);

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
          print('config unhandled message ${event.toJson()}');
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
    int result = await DB.sharedInstance.insert<ConfigDB>(configDB);
    if (result > 0) {
      configs[configDB.d] = configDB;
      _setConfig();
    }
  }

  void _setConfig() {
    String? json = configs[configD]?.configJson;
    if (json != null) {
      Map map = jsonDecode(json);

      String? wssdns = map['wssdnsnew'];
      hostConfig[wssHost] = 'wss://${wssdns ?? '52.76.210.159'}';

      String? httpsdns = map['httpsdnsnew'];
      hostConfig[httpHost] = httpsdns ?? '54.179.158.105:9602';

      List<String>? channels = (map['recommendChannels'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList();
      if (channels != null) recommendChannels = channels;

      String? mintdns = map['mintdnsnew'];
      hostConfig[mintHost] = mintdns ?? '13.38.85.175:3337';

      // String? relayGroupdns = map['wssgroupdns'];
      // hostConfig[relayGroupHost] =  relayGroupdns ?? 'ws://54.179.158.105:5577';
    }
  }
}
