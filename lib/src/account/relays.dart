import 'package:chatcore/chat-core.dart';
import 'package:http/http.dart' as http;
import 'package:nostr_core_dart/nostr.dart';

class Relays {
  /// singleton
  Relays._internal();
  factory Relays() => sharedInstance;
  static final Relays sharedInstance = Relays._internal();

  Map<String, RelayDB> relays = {};

  Future<void> init() async {
    List<RelayDB> result = await _loadRelaysFromDB() ?? [];
    if (result.isNotEmpty) {
      relays = {for (var item in result) item.url: item};
    }
  }

  Future<List<RelayDB>?> _loadRelaysFromDB() async {
    return await DB.sharedInstance.objects<RelayDB>();
  }

  Future<void> syncRelaysToDB() async {
    for (var relay in relays.values) {
      await DB.sharedInstance.insert(relay);
    }
  }

  Future<void> _syncRelayToDB(String url) async {
    var relay = relays[url];
    if (relay != null) await DB.sharedInstance.insert(relay);
  }

  int getFriendMessageUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getFriendMessageUntil(relayURL)
        : currentUnixTimestampSeconds();
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
        : currentUnixTimestampSeconds();
  }

  int getGroupMessageSince(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getGroupMessageSince(relayURL)
        : 0;
  }

  int getGroupMessageUntil(String relayURL) {
    return relays.containsKey(relayURL)
        ? relays[relayURL]!.getGroupMessageUntil(relayURL)
        : currentUnixTimestampSeconds();
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

  static Future<RelayDB?> getRelayDetails(String relayURL, {bool? refresh}) async{
    if(refresh != null && refresh == false){
      RelayDB? relayDB = await getRelayDetailsFromDB(relayURL);
      if(relayDB != null) return relayDB;
    }

    var url = Uri.parse(relayURL).replace(scheme: 'https');
    var response = await http.get(url, headers: {'Accept': 'application/nostr+json'});

    if (response.statusCode == 200) {
      RelayDB? relayDB = Relays.sharedInstance.relays.containsKey(relayURL) ? Relays.sharedInstance.relays[relayURL] : RelayDB(url: relayURL);
      relayDB = RelayDB.relayDBInfoFromJSON(response.body, relayDB!);
      await DB.sharedInstance.insert(relayDB);
      return relayDB;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
