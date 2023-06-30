import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

class Zaps {
  static Future<String> getLnurlFromLnaddr(String lnaddr) async {
    try {
      List<dynamic> parts = lnaddr.split('@');
      String name = parts[0];
      String domain = parts[1];
      if(name.isEmpty || domain.isEmpty){
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

  static Future<ZapsDB?> getZapsInfoFromLnurl(String lnurl) async {
    Map map = bech32Decode(lnurl, maxLength: lnurl.length);
    if (map['prefix'] == 'lnurl') {
      String hexURL = map['data'];
      String url = utf8.decode(hexToBytes(hexURL));
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        ZapsDB zapsDB = ZapsDB.fromMap(jsonDecode(response.body));
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

  static Future<String?> getInvoice(List<String> relays, int sats, String lnurl,
      String recipient, String privkey,
      {String? eventId, String? coordinate, String? content}) async {
    Completer<String?> completer = Completer<String?>();
    ZapsDB? zapsDB = await getZapsInfoFromLnurl(lnurl);
    if (zapsDB != null) {
      String url =
          '${zapsDB.callback}?amount=${sats * 1000}&lnurl=${zapsDB.lnURL}';
      if (zapsDB.allowsNostr == true) {
        Event event = Nip57.zapRequest(
            relays, (sats * 1000).toString(), lnurl, recipient, privkey,
            eventId: eventId, coordinate: coordinate, content: content);
        String encodedUri = Uri.encodeFull(jsonEncode(event));
        url = '$url&nostr=$encodedUri';
      }
      final result = await http.get(Uri.parse(url));
      if (result.statusCode == 200) {
        String pr = jsonDecode(result.body)['pr'];
        completer.complete(pr);
      } else {
        completer.complete(null);
      }
    } else {
      completer.complete(null);
    }
    return completer.future;
  }

  static Future<ZapReceipt?> getZapReceipt(
      String zapper,
      {String? recipient, String? eventId}) async {
    Completer<ZapReceipt?> completer = Completer<ZapReceipt?>();
    String subscriptionId = '';
    Filter f = Filter(kinds: [9735], authors: [zapper]);
    if (recipient != null) {
      f = Filter(kinds: [9735], authors: [zapper], p: [recipient]);
    }
    if (eventId != null) {
      f = Filter(kinds: [9735], authors: [zapper], e: [eventId]);
    }
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      ZapReceipt zapReceipt = Nip57.getZapReceipt(event);

      /// check invoiceAmount, lnurl?
      completer.complete(zapReceipt);
    }, eoseCallBack: (status, relay) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) completer.complete(null);
    });
    return completer.future;
  }

  static Future<void> loadZapRecordsFromRelay() async {}
  static Future<void> loadZapRecordsFromDB() async {}
}
