import 'dart:convert';
import 'dart:typed_data';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:http/http.dart' as http;

class Zaps {
  static Future<String> getLNURL(String lnaddr) async {
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

  static Future<void> getInvoice(String sender, String receiver, int sats, String lnurl, String privkey) async {
    Map map = bech32Decode(lnurl);
    if (map['prefix'] == 'lnurl') {
      String hexURL = map['data'];
      String url = utf8.decode(hexToBytes(hexURL));
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);

      } else {
        throw Exception(response.toString());
      }
    }
  }

  static Future<void> sendZapRequest() async {}
  static Future<void> getZapReceipt() async {}
  static Future<void> loadZapRecordsFromRelay() async {}
  static Future<void> loadZapRecordsFromDB() async {}
}
