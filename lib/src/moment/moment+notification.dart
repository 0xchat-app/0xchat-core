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

  Future<void> handleZapNofitication(
      ZapRecordsDB zapRecordsDB, Event zapEvent) async {
    await addZapRecordToNote(zapEvent, zapRecordsDB.eventId);

    NotificationDB notificationDB =
        NotificationDB.notificationDBFromZapRecordsDB(zapRecordsDB, zapRecordsDB.eventId);
    await DB.sharedInstance.insert<NotificationDB>(notificationDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    Moment.sharedInstance.newNotifications.add(notificationDB);
    Moment.sharedInstance.newNotificationCallBack
        ?.call(Moment.sharedInstance.newNotifications);
  }
}
