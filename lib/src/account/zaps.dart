import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef GetInvoiceCallBack = void Function(String?);
typedef GetZapReceiptCallBack = void Function(ZapReceipt?);

class Zaps {
  static Future<String> getLnurlFromLnaddr(String lnaddr) async {
    try {
      List<dynamic> parts = lnaddr.split('@');
      String name = parts[0];
      String domain = parts[1];
      String url = 'https://${domain}/.well-known/lnurlp/${name}';
      List<int> bytes = utf8.encode(url);
      String hex = bytesToHex(Uint8List.fromList(bytes));
      return bech32Encode('lnurl', hex);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<ZapsDB?> getZapsInfoFromLnurl(String lnurl) async {
    Map map = bech32Decode(lnurl);
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

  static Future<void> getInvoice(List<String> relays, int sats, String lnurl,
      String recipient, String privkey, GetInvoiceCallBack callBack,
      {String? eventId, String? coordinate, String? content}) async {
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
        callBack(pr);
      } else {
        callBack(null);
      }
    } else {
      callBack(null);
    }
  }

  static Future<void> getZapReceipt(
      String zapper, GetZapReceiptCallBack callBack,
      {String? recipient, String? eventId}) async {
    String subscriptionId = '';
    Filter f = Filter(kinds: [9735], authors: [zapper]);
    if (recipient != null) {
      f = Filter(kinds: [9735], authors: [zapper], p: [recipient]);
    }
    if (eventId != null) {
      f = Filter(kinds: [9735], authors: [zapper], e: [eventId]);
    }
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      ZapReceipt zapReceipt = Nip57.getZapReceipt(event);
      /// check invoiceAmount, lnurl?
      callBack(zapReceipt);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) callBack(null);
    });
  }

  static Future<void> loadZapRecordsFromRelay() async {}
  static Future<void> loadZapRecordsFromDB() async {}
}
