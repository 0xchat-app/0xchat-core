import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension IsolateEvent on Contacts {
  static Future<Map<String, dynamic>?> decodeNip17InIsolate(Map<String, dynamic> params) async {
    String privkey = params['privkey'] ?? '';
    String pubkey = params['pubkey'] ?? '';
    Event event = await Event.fromJson(params['event'], verify: false);
    Event? innerEvent = await Nip17.decode(event, pubkey, privkey);
    return innerEvent?.toJson();
  }

  Future<Event?> decodeNip17Event(Event event) async {
    Map<String, dynamic> map = {
      'event': event.toJson(),
      'privkey': privkey,
      'pubkey': pubkey,
    };
    var message =
        await ThreadPoolManager.sharedInstance.runOtherTask(() => decodeNip17InIsolate(map));
    if (message != null) {
      return Event.fromJson(message, verify: false);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> decodeNip4InIsolate(Map<String, dynamic> params) async {
    String privkey = params['privkey'] ?? '';
    String receiver = params['receiver'] ?? '';
    Event event = await Event.fromJson(params['event'], verify: false);
    EDMessage? message = await Nip4.decode(event, receiver, privkey);
    return message?.toMap();
  }

  Future<EDMessage?> decodeNip4Event(Event event, String receiver, String privkey) async {
    Map<String, dynamic> map = {
      'event': event.toJson(),
      'privkey': privkey,
      'receiver': receiver,
    };
    var message =
        await ThreadPoolManager.sharedInstance.runOtherTask(() => decodeNip4InIsolate(map));
    if (message != null) {
      return EDMessage.fromMap(message);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> decodeNip44InIsolate(Map<String, dynamic> params) async {
    String privkey = params['privkey'] ?? '';
    String receiver = params['receiver'] ?? '';
    Event event = await Event.fromJson(params['event'], verify: false);
    EDMessage? message = await Nip44.decode(event, receiver, privkey);
    return message?.toMap();
  }

  Future<EDMessage?> decodeNip44Event(Event event, String receiver, String privkey) async {
    Map<String, dynamic> map = {
      'event': event.toJson(),
      'privkey': privkey,
      'receiver': receiver,
    };
    var message =
        await ThreadPoolManager.sharedInstance.runOtherTask(() => decodeNip44InIsolate(map));
    if (message != null) {
      return EDMessage.fromMap(message);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> decodeKind14InIsolate(Map<String, dynamic> params) async {
    String receiver = params['receiver'] ?? '';
    Event event = await Event.fromJson(params['event'], verify: false);
    EDMessage? message = await Nip17.decodeSealedGossipDM(event, receiver);
    return message?.toMap();
  }

  Future<EDMessage?> decodeKind14Event(Event event, String receiver) async {
    Map<String, dynamic> map = {
      'event': event.toJson(),
      'receiver': receiver,
    };
    var message =
        await ThreadPoolManager.sharedInstance.runOtherTask(() => decodeKind14InIsolate(map));
    if (message != null) {
      return EDMessage.fromMap(message);
    }
    return null;
  }

  static Future<Map<String, dynamic>> encodeNip17InIsolate(Map<String, dynamic> params) async {
    Event event = await Event.fromJson(params['event']);
    String receiver = params['receiver'] ?? '';
    Event sealedEvent = await Nip17.encode(
        event, receiver, params['pubkey'] ?? '', params['privkey'] ?? '',
        sealedPrivkey: params['sealedPrivkey'], sealedReceiver: params['sealedReceiver']);
    return sealedEvent.toJson();
  }

  Future<Event?> encodeNip17Event(Event event, String receiver,
      {String? sealedReceiver, String? sealedPrivkey}) async {
    Map<String, dynamic> map = {
      'event': event.toJson(),
      'receiver': receiver,
      'privkey': privkey,
      'pubkey': pubkey,
      'sealedPrivkey': sealedPrivkey,
      'sealedReceiver': sealedReceiver
    };
    var message =
        await ThreadPoolManager.sharedInstance.runOtherTask(() => encodeNip17InIsolate(map));
    if (message != null) {
      return Event.fromJson(message, verify: false);
    }
    return null;
  }
}
