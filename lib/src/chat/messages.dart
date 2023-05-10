import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

class Messages {
  static Future<List<MessageDB?>> loadMessagesFromDB() async {
    List<MessageDB> messages = await DB.sharedInstance.objects<MessageDB>();
    for (MessageDB message in messages) {
      if (message.kind == 4) {
        // private message
        UserDB? friend = Friends.sharedInstance.friends[message.sender];
        if (friend != null) {
          String content = Nip4.decryptContent(
            message.content!,
            friend.toAliasPrivkey!,
            friend.toAliasPubkey!,
          );
          message.decryptContent = MessageDB.decodeContent(content)['content'];
          message.type = MessageDB.stringtoMessageType(
              MessageDB.decodeContent(content)['contentType']);
        }
      }
    }
    return messages;
  }

  static saveMessagesToDB(List<MessageDB> messages) async {
    for (var message in messages) {
      await DB.sharedInstance.insert<MessageDB>(message);
    }
  }
}
