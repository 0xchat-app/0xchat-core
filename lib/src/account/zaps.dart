import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef ZapRecordsCallBack = void Function(ZapRecordsDB);

class Zaps {
  /// singleton
  Zaps._internal();
  factory Zaps() => sharedInstance;
  static final Zaps sharedInstance = Zaps._internal();

  Map<String, ZapRecordsDB> zapRecords = {};
  ZapRecordsCallBack? zapRecordsCallBack;
  NostrWalletConnection? nwc;
  String nwcSubscription = '';
  String currentPubkey = '';

  void _connectToRelay(List<String> relays) {
    for (var relay in relays) {
      if (relay.isNotEmpty &&
          !Connect.sharedInstance.relays(type: 1).contains(relay)) {
        Connect.sharedInstance.connect(relay, type: 1);
      }
    }
  }

  void init() {
    currentPubkey = Account.sharedInstance.me!.pubKey;
    updateNWC(null);
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 &&
          Account.sharedInstance.me != null &&
          nwc?.relays.contains(relay) == true) {
        updateNWCSubscription(relay: relay);
      }
    });
  }

  NostrWalletConnection? updateNWC(String? nwcURI) {
    if(nwcURI != null && nwcURI != Account.sharedInstance.me?.nwcURI){
      Account.sharedInstance.me?.nwcURI = nwcURI;
      Account.sharedInstance.syncMe();
    }
    nwc = Account.sharedInstance.me?.nwc;
    if (nwc != null) {
      _connectToRelay(nwc!.relays);
    }
    updateNWCSubscription();
    return nwc;
  }

  Future<OKEvent> requestNWC(String invoice) {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (nwc == null) {
      completer.complete(OKEvent(invoice, false, 'nwc not exit'));
    }
    Event event = Nip47.request(invoice, nwc!.server, nwc!.secret);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  void updateNWCSubscription({String? relay}) {
    if (nwc == null) return;
    if (nwcSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(nwcSubscription, relay: relay);
    }
    Map<String, List<Filter>> subscriptions = {};

    if (relay == null) {
      for (String relayURL in nwc!.relays) {
        Filter f = Filter(
            kinds: [23195],
            p: [currentPubkey],
            since: currentUnixTimestampSeconds());
        subscriptions[relayURL] = [f];
      }
    } else {
      Filter f = Filter(
          kinds: [23195],
          p: [currentPubkey],
          since: currentUnixTimestampSeconds());
      subscriptions[relay] = [f];
    }

    nwcSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      PayInvoiceResult? payInvoiceResult =
          Nip47.response(event, currentPubkey, nwc!.secret);
      if (payInvoiceResult != null) {
        print(
            'nwc success: ${payInvoiceResult.preimage}, id: ${payInvoiceResult.requestId}');
      }
    });
  }

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

  static Future<Map<String, dynamic>> getInvoice(
      List<String> relays, int sats, String lnurl, String recipient,
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
        Event event = await Nip57.zapRequest(
            relays,
            (sats * 1000).toString(),
            lnurl,
            recipient,
            Account.sharedInstance.currentPrivkey,
            privateZap ?? false,
            eventId: eventId,
            coordinate: coordinate,
            content: content);
        String encodedUri = Uri.encodeFull(jsonEncode(event));
        url = '$url&nostr=$encodedUri';
      }
      final result = await http.get(Uri.parse(url));
      if (result.statusCode == 200) {
        try {
          String pr = jsonDecode(result.body)['pr'];
          if (!completer.isCompleted) {
            completer.complete({"invoice": pr, "zapsDB": zapsDB});
          }
        } catch (_) {
          if (!completer.isCompleted) {
            completer.complete({"invoice": '', "zapsDB": zapsDB});
          }
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

  static Future<List<ZapRecordsDB>> getZapReceipt(String zapper,
      {String? recipient, String? eventId, String? invoice}) async {
    if (invoice != null) {
      // load from cache
      if (Zaps.sharedInstance.zapRecords.containsKey(invoice)) {
        var db = Zaps.sharedInstance.zapRecords[invoice];
        return [db!];
      } else {
        // load from db
        List<ZapRecordsDB?> maps = await Zaps.loadZapRecordsFromDB(
            where: 'bolt11 = ?', whereArgs: [invoice]);
        if (maps.isNotEmpty) {
          var db = maps.first;
          if (db != null) {
            Zaps.sharedInstance.zapRecords[db.bolt11] = db;
            return [db];
          }
        }
      }
    }
    // load from relay
    Completer<List<ZapRecordsDB>> completer = Completer<List<ZapRecordsDB>>();
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
      if (zapReceiptList.isNotEmpty) {
        List<ZapRecordsDB> result = [];
        for (var event in zapReceiptList) {
          ZapRecordsDB zapRecordsDB = await handleZapRecordEvent(event);
          result.add(zapRecordsDB);
        }
        if (!completer.isCompleted) completer.complete(result);
      }
      if (unRelays.isEmpty && !completer.isCompleted) completer.complete([]);
    });
    return completer.future;
  }

  static Future<List<ZapRecordsDB?>> loadZapRecordsFromDB(
      {String? where,
      List<Object?>? whereArgs,
      String? orderBy,
      int? limit,
      int? offset}) async {
    List<ZapRecordsDB?> maps = await DB.sharedInstance.objects<ZapRecordsDB>(
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
    for (ZapRecordsDB? records in maps) {
      if (records != null) {
        Zaps.sharedInstance.zapRecords[records.bolt11] = records;
      }
    }
    return maps;
  }

  static Future<ZapRecordsDB> handleZapRecordEvent(Event event) async {
    ZapReceipt zapReceipt =
        await Nip57.getZapReceipt(event, Account.sharedInstance.currentPrivkey);
    ZapRecordsDB zapRecordsDB =
        ZapRecordsDB.zapReceiptToZapRecordsDB(zapReceipt);
    await DB.sharedInstance.insert<ZapRecordsDB>(zapRecordsDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    Zaps.sharedInstance.zapRecords[zapRecordsDB.bolt11] = zapRecordsDB;
    Zaps.sharedInstance.zapRecordsCallBack?.call(zapRecordsDB);
    return zapRecordsDB;
  }
}
