import 'package:chatcore/chat-core.dart';
import 'package:http/http.dart' as http;

class Relays {
  /// singleton
  Relays._internal();
  factory Relays() => sharedInstance;
  static final Relays sharedInstance = Relays._internal();
  // ALL relays list
  Map<String, RelayDB> relays = {};

  List<String> recommendGeneralRelays = [
    'wss://relay.0xchat.com',
    'wss://yabu.me',
    'wss://relay.siamstr.com',
    'wss://relay.damus.io',
    'wss://relay.nostr.band',
    'wss://nos.lol',
    'wss://nostr.wine',
    'wss://nostr.coinfund.app',
    'wss://eden.nostr.land'
  ];

  List<String> recommendDMRelays = [
    'wss://auth.nostr1.com',
    'wss://relay.0xchat.com'
  ];

  List<String> recommendGroupRelays = [
    'wss://groups.0xchat.com',
    'wss://groups.fiatjaf.com',
  ];

  List<String> recommendSecretChatRelays = [
    'wss://auth.nostr1.com',
    'wss://inbox.nostr.wine',
    'wss://relay.0xchat.com'
  ];

  Future<void> init() async {
    await Config.sharedInstance.initConfig();
    List<RelayDB> result = await _loadRelaysFromDB() ?? [];
    if (result.isNotEmpty) {
      relays = {for (var item in result) item.url: item};
    }
    connectGeneralRelays();
    connectDMRelays();
  }

  Future<void> connectGeneralRelays() async {
    List<String> connectedGeneralRelays =
        Connect.sharedInstance.relays(relayKind: RelayKind.general);
    List<String> generalRelays = Account.sharedInstance.me?.relayList ?? [];
    List<String> notInGeneralRelays = connectedGeneralRelays
        .where((relay) => !generalRelays.contains(relay))
        .toList();
    await Connect.sharedInstance
        .closeConnects(notInGeneralRelays, RelayKind.general);

    int updatedTime = Account.sharedInstance.me?.lastRelayListUpdatedTime ?? 0;
    if (updatedTime > 0 && generalRelays.isNotEmpty) {
      Connect.sharedInstance
          .connectRelays(generalRelays, relayKind: RelayKind.general);
    } else {
      Account.sharedInstance.me!.relayList = recommendGeneralRelays;
      Connect.sharedInstance
          .connectRelays(recommendGeneralRelays, relayKind: RelayKind.general);
    }
  }

  Future<void> connectDMRelays() async {
    List<String> connectedDMRelays =
        Connect.sharedInstance.relays(relayKind: RelayKind.dm);
    List<String> dmRelays = Account.sharedInstance.me?.dmRelayList ?? [];
    List<String> notInDMRelays =
        connectedDMRelays.where((relay) => !dmRelays.contains(relay)).toList();
    await Connect.sharedInstance.closeConnects(notInDMRelays, RelayKind.dm);

    Connect.sharedInstance.connectRelays(dmRelays, relayKind: RelayKind.dm);
  }

  Future<List<RelayDB>?> _loadRelaysFromDB() async {
    return await DB.sharedInstance.objects<RelayDB>();
  }

  Future<void> syncRelaysToDB({String? r}) async {
    if (r != null && relays[r] != null) {
      await DB.sharedInstance.insertBatch(relays[r]!);
    } else {
      await Future.forEach(relays.values, (relay) async {
        await DB.sharedInstance.insertBatch(relay);
      });
    }
  }

  Future<void> _syncRelayToDB(String url) async {
    var relay = relays[url];
    if (relay != null) await DB.sharedInstance.insertBatch(relay);
  }

  int getFriendMessageUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getFriendMessageUntil(relayURL)
        : 0;
  }

  int getFriendMessageSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getFriendMessageSince(relayURL)
        : 0;
  }

  int getChannelMessageSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getChannelMessageSince(relayURL)
        : 0;
  }

  int getChannelMessageUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getChannelMessageUntil(relayURL)
        : 0;
  }

  int getGroupMessageSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getGroupMessageSince(relayURL)
        : 0;
  }

  int getGroupMessageUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getGroupMessageUntil(relayURL)
        : 0;
  }

  int getContactsNotesSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getContactsNotesSince(relayURL)
        : 0;
  }

  int getContactsNotesUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getContactsNotesUntil(relayURL)
        : 0;
  }

  int getMomentSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getMomentSince(relayURL)
        : 0;
  }

  int getMomentUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getMomentUntil(relayURL)
        : 0;
  }

  int getZapRecordSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getZapRecordSince(relayURL)
        : 0;
  }

  int getZapRecordUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getZapRecordUntil(relayURL)
        : 0;
  }

  int getCommonMessageUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.commonMessagesUntil
        : 0;
  }

  int getCommonMessageSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.commonMessagesSince
        : 0;
  }

  void setCommonMessageUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getCommonMessageUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    relays[relay]!.commonMessagesUntil =
        updateTime > until ? updateTime : until;
  }

  void setFriendMessageUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getFriendMessageUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.friendMessageUntil![relay] =
        updateTime > until ? updateTime : until;
  }

  void setFriendRequestUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.relays[relay]!.friendRequestUntil;
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.friendRequestUntil =
        updateTime > until ? updateTime : until;
  }

  void setChannelMessageUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getChannelMessageUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.channelMessageUntil![relay] =
        updateTime > until ? updateTime : until;
  }

  void setContactsNotesUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getContactsNotesUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.contactsNotesUntil![relay] =
        updateTime > until ? updateTime : until;
  }

  void setMomentUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getMomentUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.momentUntil![relay] =
        updateTime > until ? updateTime : until;
  }

  void setZapRecordUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getZapRecordUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.zapRecordUntil![relay] =
        updateTime > until ? updateTime : until;
  }

  void setGroupMessageUntil(int updateTime, String relay) {
    int until = Relays.sharedInstance.getGroupMessageUntil(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.groupMessageUntil![relay] =
        updateTime > until ? updateTime : until;
  }

  void setCommonMessageSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getCommonMessageSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    relays[relay]!.commonMessagesSince =
        updateTime < since ? updateTime : since;
  }

  void setFriendMessageSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getFriendMessageSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.friendMessageSince![relay] =
        updateTime < since ? updateTime : since;
  }

  void setFriendRequestSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.relays[relay]!.friendRequestSince;
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.friendRequestSince =
        updateTime < since ? updateTime : since;
  }

  void setChannelMessageSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getChannelMessageSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.channelMessageSince![relay] =
        updateTime < since ? updateTime : since;
  }

  void setContactsNotesSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getContactsNotesSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.contactsNotesSince![relay] =
        updateTime < since ? updateTime : since;
  }

  void setMomentSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getMomentSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.momentSince![relay] =
        updateTime < since ? updateTime : since;
  }

  void setZapRecordSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getZapRecordSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.zapRecordSince![relay] =
        updateTime < since ? updateTime : since;
  }

  void setGroupMessageSince(int updateTime, String relay) {
    int since = Relays.sharedInstance.getGroupMessageSince(relay);
    if (!relays.containsKey(relay)) relays[relay] = RelayDB(url: relay);
    Relays.sharedInstance.relays[relay]!.groupMessageSince![relay] =
        updateTime < since ? updateTime : since;
  }

  static Future<RelayDB?> getRelayDetailsFromDB(String relayURL) async {
    List<Object?> maps = await DB.sharedInstance
        .objects<RelayDB>(where: 'url = ?', whereArgs: [relayURL]);
    RelayDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as RelayDB?;
      if (db != null) {
        return db;
      }
    }
    return null;
  }

  static Future<RelayDB?> getRelayDetails(String relayURL,
      {bool? refresh}) async {
    if (refresh != true) {
      RelayDB? relayDB = await getRelayDetailsFromDB(relayURL);
      if (relayDB != null) return relayDB;
    }

    var url = Uri.parse(relayURL).replace(scheme: 'https');
    var response =
        await http.get(url, headers: {'Accept': 'application/nostr+json'});

    if (response.statusCode == 200) {
      RelayDB? relayDB = Relays.sharedInstance.relays.containsKey(relayURL)
          ? Relays.sharedInstance.relays[relayURL]
          : RelayDB(url: relayURL);
      relayDB = RelayDB.relayDBInfoFromJSON(response.body, relayDB!);
      await DB.sharedInstance.insertBatch(relayDB);
      return relayDB;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
