import 'package:chatcore/chat-core.dart';

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
}
