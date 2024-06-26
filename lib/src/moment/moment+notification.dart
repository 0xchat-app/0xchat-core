import 'package:nostr_core_dart/nostr.dart';
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

  Future<void> handleZapNotification(
      ZapRecordsDB zapRecordsDB, Event zapEvent) async {
    final reactedMessageDB = await Messages.sharedInstance
        .loadMessageDBFromDB(zapRecordsDB.eventId);
    if (reactedMessageDB != null) {
      await Messages.sharedInstance.handleZapRecordEvent(zapEvent);
    }
    else{
      await addZapRecordToNote(zapEvent, zapRecordsDB.eventId);
      NotificationDB notificationDB =
      NotificationDB.notificationDBFromZapRecordsDB(
          zapRecordsDB, zapEvent.id);
      int result = await DB.sharedInstance.insert<NotificationDB>(notificationDB,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      if (result > 0) {
        if (notificationDB.author != pubkey) {
          Moment.sharedInstance.newNotifications.add(notificationDB);
          Moment.sharedInstance.newNotificationCallBack
              ?.call(Moment.sharedInstance.newNotifications);
        } else {
          Moment.sharedInstance.myZapNotificationCallBack?.call([notificationDB]);
        }
      }
    }
  }

  Future<void> deleteAllNotifications() async {
    newNotifications.clear();
    await DB.sharedInstance.delete<NotificationDB>();
  }
}
