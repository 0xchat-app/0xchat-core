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
}
