import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

class NpubCash {
  static String address(String pubkey) {
    return '${Nip19.encodePubkey(pubkey)}@npub.cash';
  }

  static Future<String?> claim() async {
    String url = 'https://npub.cash/api/v1/claim';
    String authToken = await Nip98.base64Event(
        url,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Nostr $authToken',
      },
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      if (body['error'] == false) {
        var data = body['data'];
        var token = data['token'];
        return token;
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    return null;
  }
}
