# 0xChat-Core

Welcome to 0xChat⚡️

0xchat is a secure chat app built on the Nostr protocol. It prioritizes privacy, featuring private key login, encrypted private chats and contacts, encrypted group chats, and private payments([Cashu](https://cashu.space/)). Additionally, it also offers an open communication platform through public channels.

0xchat Download links:

  - [0xchat on Appstore](https://apps.apple.com/app/0xchat/id1637607169)
  - [0xchat Testflight](https://testflight.apple.com/join/AjdJFBmU)
  - [0xchat on Google play](https://play.google.com/store/apps/details?id=com.oxchat.nostr)
  - [0xchat APK download](https://github.com/0xchat-app/0xchat-app-main/releases)

![](https://github.com/0xchat-app/.github/blob/main/profile/banner.jpeg)

## Language & Platforms
The repository is primarily implemented in Dart, allowing you to swiftly create versions for iOS, Android, and Desktop.

## Getting Started
You can start by cloning this repository to your local machine using the command:

```git
git clone https://github.com/0xChat/0xChat-Core.git
```

## Modules
At present, the repository supports the following modules and functionalities:

1. **Account Module**: This module handles all account-related operations. It allows for account creation, user data requests, and caching of user information, among other features.

2. **Chat Module**: The chat module offers encrypted private chatting, encrypted contact lists, and open channels.
3. **Common Module**: The Common Module provides database integration and establishes connections with relay services.

## Features

**Secure DM**

Currently, we support three types of direct messages (DMs):

- [Normal DM](https://github.com/nostr-protocol/nips/blob/master/04.md)

Nip04 DM is the most widely used DM type in nostr, but it is not our recommended option currently because nip04 is not private in terms of DMs. Even though the content is encrypted, it leaks a lot of metadata. We do not use this DM type by default but are compatible with Nip04 DM from other nostr clients.

- [Gift-Wrapped DM](https://github.com/nostr-protocol/nips/blob/master/59.md)

This is our default and recommended DM type. By using Gift-Wrapped for event messages, it minimizes metadata leakage. Not only is the message content encrypted, but the sender and the timestamp are also concealed. Moreover, the encryption algorithm employed is the latest audited [nip44](https://github.com/nostr-protocol/nips/blob/master/44.md) algorithm.

- [Secret DM](https://github.com/0xchat-app/0xchat-core/blob/main/doc/secretChat.md)

Secret Chat is our third DM type, an extension of the Gift-Wrapped DM. Since Gift-Wrapped DM does not support forward secrecy, if a user's private key is compromised, all DM messages could be recovered. Therefore, we added a [nip101](https://github.com/water783/nips/blob/nip101/101.md) key exchange protocol to ensure each message session uses a different receiver key, securing forward secrecy. Additionally, we have incorporated the option to select a fixed relay for these sessions, allowing messages to be transmitted through a single trusted relay for both parties.

Please review the provided links for a deeper understanding of each DM type.

**Private Group**

For [private group](https://github.com/0xchat-app/0xchat-core/blob/main/doc/privateGroup.md), we combine [Nip28](https://github.com/nostr-protocol/nips/blob/master/28.md) and [Nip59](https://github.com/nostr-protocol/nips/blob/master/59.md) to support group member management, where group messages, processed through gift-wrapping, are sent to all group members, ensuring messages are received only by group members even with frequent joins and leaves.

Since our private group chats do not use a shared group private key, each group message is individually encrypted and sent to group members, which is not ideal for large groups. After testing, the 0xchat app, with a multi-threading approach, can support groups with fewer than 500 members.

**Open Channels**

We also provide an open channels feature, compatible with other nostr clients. These channels are public, allowing anyone to join and speak, with message content visible to all. This feature is primarily aimed at fostering community and enhancing chat enjoyment.

**Audio & Video Call**

We offer E2EE audio and video call functionalities between contacts. Signaling communication is conducted through Nostr relay using [NIP100](https://github.com/jacany/nips/blob/webrtc/100.md), with actual audio and video calls facilitated via ICE servers. Users can also choose their preferred ICE servers.

**Push Notifications**

0xchat proposes a push notification method, involving sending and processing heartbeat signals to determine online status and ensure timely notifications.

Spec link: [https://github.com/0xchat-app/0xchat-core/blob/main/doc/nofitications.md](https://github.com/0xchat-app/0xchat-core/blob/main/doc/nofitications.md)

In the latest Android version, we have integrated [Unifiedpush](https://unifiedpush.org/) with an embedded FCM distributor, also allowing users to select their preferred distributor in the settings.

**Private Payments**

We have integrated a cashu wallet into the app, utilizing the Lightning Network for ecash deposits and withdrawals. Within the app, users can send Ecash to friends and group members. The Ecash is stored locally, anonymizing ownership and effectively protecting user privacy.

**Badge Collections**

Finally, we offer a badge collection feature, where you can obtain badges of different levels by making donations to us. You can set these badges as your profile picture and also enjoy the corresponding privileges.

## Nips Supported
- [x] [NIP 01 Basic protocol flow description](https://github.com/nostr-protocol/nips/blob/master/01.md)
- [x] [NIP 02 Contact List and Petnames](https://github.com/nostr-protocol/nips/blob/master/02.md)
- [x] [NIP 04 Encrypted Direct Message](https://github.com/nostr-protocol/nips/blob/master/04.md)
- [x] [NIP 05 Mapping Nostr keys to DNS-based internet identifiers](https://github.com/nostr-protocol/nips/blob/master/05.md)
- [x] [NIP 09 Event Deletion](https://github.com/nostr-protocol/nips/blob/master/09.md)
- [x] [NIP 10 On "e" and "p" tags in Text Events (kind 1)](https://github.com/nostr-protocol/nips/blob/master/10.md)
- [x] [NIP 15 End of Stored Events Notice](https://github.com/nostr-protocol/nips/blob/master/15.md)
- [x] [NIP 19 bech32-encoded entities](https://github.com/nostr-protocol/nips/blob/master/19.md)
- [x] [NIP 20 Command Results](https://github.com/nostr-protocol/nips/blob/master/20.md)
- [x] [NIP 21 nostr: URI scheme](https://github.com/nostr-protocol/nips/blob/master/21.md)
- [x] [NIP 28 Public Chat](https://github.com/nostr-protocol/nips/blob/master/28.md)
- [x] [NIP 33 Parameterized Replaceable Events](https://github.com/nostr-protocol/nips/blob/master/33.md)
- [x] [NIP 51 Lists](https://github.com/nostr-protocol/nips/blob/master/51.md)
- [x] [NIP 57 Lightning Zaps](https://github.com/nostr-protocol/nips/blob/master/57.md)
- [x] [NIP 58 Badges](https://github.com/nostr-protocol/nips/blob/master/58.md)


### Nips for 0xchat
- [x] [NIP 101 Alias Key Exchange](https://github.com/water783/nips/blob/nip101/101.md)
- [x] [NIP XXX Push Notifications](https://github.com/0xchat-app/0xchat-core/blob/main/doc/nofitications.md)
- [x] [NIP 100 WebRTC](https://github.com/jacany/nips/blob/webrtc/100.md)



## Future Enhancements
We continuously aim to improve and enhance the features provided by this repository. Stay tuned for future updates!

Some important planned features:

- [x] Threads, mentions, reactions
- [x] Zap Red Envelopes between friends
- [x] P2P audio/video calling
- [x] Private group
- [ ] Audio/video chat room
- [ ] Lightning wallet Integration
- [ ] Private notes

## Support

We encourage contributions from the developer community! To contribute, please fork this repository, make your changes, and submit a pull request. 
If you encounter any issues or have questions, feel free to open an issue in this repository.

For more details and updates, please visit the official [0xChat website](https://www.0xchat.com).