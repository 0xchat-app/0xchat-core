import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class Messages {
  static Future<Map> loadMessagesFromDB(
      {String? where, List<Object?>? whereArgs}) async {
    int theLastTime = 0;
    List<MessageDB> messages = await DB.sharedInstance
        .objects<MessageDB>(where: where, whereArgs: whereArgs);
    for (MessageDB message in messages) {
      theLastTime =
          message.createTime! > theLastTime ? message.createTime! : theLastTime;
      if (message.kind == 4) {
        // private message
        String sender = (message.sender == Friends.sharedInstance.pubkey)
            ? message.receiver!
            : message.sender!;
        UserDB? friend = Friends.sharedInstance.friends[sender];
        if (friend != null && friend.aliasPubkey!.isNotEmpty) {
          String content = Nip4.decryptContent(
            message.content!,
            friend.toAliasPrivkey!,
            friend.aliasPubkey!,
          );
          Map<String, dynamic> decodeContent = MessageDB.decodeContent(content);
          message.decryptContent = decodeContent['content'];
          message.type =
              MessageDB.stringtoMessageType(decodeContent['contentType']);
        }
      } else if (message.kind == 42) {
        // channel message
        Map<String, dynamic> decodeContent =
            MessageDB.decodeContent(message.content!);
        message.decryptContent = decodeContent['content'];
        message.type =
            MessageDB.stringtoMessageType(decodeContent['contentType']);
      }
    }
    return {'theLastTime': theLastTime, 'messages': messages};
  }

  static saveMessagesToDB(List<MessageDB> messages) async {
    for (var message in messages) {
      await DB.sharedInstance.insert<MessageDB>(message);
    }
  }

  static deleteMessagesFromDB(List<MessageDB> messages) async {
    await DB.sharedInstance.delete<MessageDB>(
        where: 'messageId = ?',
        whereArgs: messages.map((e) => e.messageId).toList());
  }
}
