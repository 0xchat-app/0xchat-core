import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef NewNotesCallBack = void Function(NoteDB);

class Moment {
  /// singleton
  Moment._internal();
  factory Moment() => sharedInstance;
  static final Moment sharedInstance = Moment._internal();

  /// memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, NoteDB> notesCache = {};
  NewNotesCallBack? newPrivateNotesCallBack;
  NewNotesCallBack? newContactsNotesCallBack;
  NewNotesCallBack? newUserNotesCallBack;

  Future<void> init() async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
  }
}