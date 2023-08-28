import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';

class Zaps {
  static Future<String> getLnurlFromLnaddr(String lnaddr) async {
    try {
      List<dynamic> parts = lnaddr.split('@');
      String name = parts[0];
      String domain = parts[1];
      if (name.isEmpty || domain.isEmpty) {
        throw Exception('invalid lnaddr');
      }
      String url = 'https://$domain/.well-known/lnurlp/$name';
      List<int> bytes = utf8.encode(url);
      String hex = bytesToHex(Uint8List.fromList(bytes));
      return bech32Encode('lnurl', hex, maxLength: 200);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<ZapsDB?> getZapsInfoFromDB(String lnurl) async {
    List<ZapsDB?> maps = await DB.sharedInstance
        .objects<ZapsDB>(where: 'lnURL = ?', whereArgs: [lnurl]);
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  static Future<ZapsDB?> getZapsInfoFromLnurl(String lnurl) async {
    ZapsDB? zapsDB = await getZapsInfoFromDB(lnurl);
    if (zapsDB != null) return zapsDB;
    Map map = bech32Decode(lnurl, maxLength: lnurl.length);
    if (map['prefix'] == 'lnurl') {
      String hexURL = map['data'];
      String url = utf8.decode(hexToBytes(hexURL));
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        zapsDB = ZapsDB.fromMap(jsonDecode(response.body));
        zapsDB.lnURL = lnurl;
        // cache to DB
        await DB.sharedInstance.insert<ZapsDB>(zapsDB);
        return zapsDB;
      } else {
        throw Exception(response.toString());
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getInvoice(List<String> relays, int sats,
      String lnurl, String recipient, String privkey,
      {String? eventId,
      String? coordinate,
      String? content,
      bool? privateZap}) async {
    Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
    ZapsDB? zapsDB = await getZapsInfoFromLnurl(lnurl);
    if (zapsDB != null) {
      String url =
          '${zapsDB.callback}?amount=${sats * 1000}&lnurl=${zapsDB.lnURL}';
      if (zapsDB.allowsNostr == true) {
        Event event = await Nip57.zapRequest(relays, (sats * 1000).toString(),
            lnurl, recipient, privkey, privateZap ?? false,
            eventId: eventId, coordinate: coordinate, content: content);
        String encodedUri = Uri.encodeFull(jsonEncode(event));
        url = '$url&nostr=$encodedUri';
      }
      final result = await http.get(Uri.parse(url));
      if (result.statusCode == 200) {
        String pr = jsonDecode(result.body)['pr'];
        if (!completer.isCompleted) {
          completer.complete({"invoice": pr, "zapsDB": zapsDB});
        }
      } else {
        if (!completer.isCompleted) {
          completer.complete({"invoice": '', "zapsDB": zapsDB});
        }
      }
    } else {
      if (!completer.isCompleted) {
        completer.complete({"invoice": '', "zapsDB": zapsDB});
      }
    }
    return completer.future;
  }

  static Bolt11PaymentRequest getPaymentRequestInfo(String invoice) {
    return Bolt11PaymentRequest(invoice);
  }

  static Future<List<ZapReceipt>> getZapReceipt(String zapper, String privkey,
      {String? recipient, String? eventId, String? invoice}) async {
    Completer<List<ZapReceipt>> completer = Completer<List<ZapReceipt>>();
    Filter f = Filter(kinds: [9735], authors: [zapper]);
    if (recipient != null) {
      f = Filter(kinds: [9735], authors: [zapper], p: [recipient]);
    }
    if (eventId != null) {
      f = Filter(kinds: [9735], authors: [zapper], e: [eventId]);
    }
    if (invoice != null) {
      f = Filter(kinds: [9735], authors: [zapper], bolt11: [invoice]);
    }
    List<Event> zapReceiptList = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      zapReceiptList.add(event);
    }, eoseCallBack: (requestId, status, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<ZapReceipt> result = [];
        for (var event in zapReceiptList) {
          ZapReceipt zapReceipt = await Nip57.getZapReceipt(event, privkey);
          result.add(zapReceipt);
        }
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  static Future<void> loadZapRecordsFromRelay() async {}
  static Future<void> loadZapRecordsFromDB() async {}
}
