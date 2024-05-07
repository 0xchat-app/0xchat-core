import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:chatcore/chat-core.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Notification on Moment {
  Future<List<NotificationDB>?> loadNotificationsFromDB(int until,
      {int limit = 50}) async {
    List<NotificationDB>? notifications = await DB.sharedInstance
        .objects<NotificationDB>(
            where: 'createAt < ?',
            whereArgs: [until],
            orderBy: 'createAt desc',
            limit: limit);
    return notifications;
  }

  Future<void> handleZapNofitication(
      ZapRecordsDB zapRecordsDB, String noteId) async {
    NoteDB? note = await loadNoteWithNoteId(noteId);
    if (note != null) {
      note.zapCount++;
      Bolt11PaymentRequest requestInfo =
          Zaps.getPaymentRequestInfo(zapRecordsDB.bolt11);
      note.zapAmount += (requestInfo.amount.toDouble() * 100000000).toInt();
      await saveNoteToDB(note);
    }

    NotificationDB notificationDB =
        NotificationDB.notificationDBFromZapRecordsDB(zapRecordsDB, noteId);
    await DB.sharedInstance.insert<NotificationDB>(notificationDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    Moment.sharedInstance.newNotifications.add(notificationDB);
    Moment.sharedInstance.newNotificationCallBack
        ?.call(Moment.sharedInstance.newNotifications);
  }
}
