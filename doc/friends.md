# Private Messaging in 0xchat

## Introduction

0xchat has optimized private messaging based on NIP04 to prevent leakage of users' real public keys (pubkeys) during private chats. This is achieved by implementing the [NIP101](https://github.com/water783/nips/blob/nip101/101.md) protocol, which creates an alias for users during private conversations. The following documentation outlines this process in detail.

## Process Flow Diagram

```
User A                    User B
  |                          |
  |--> [Create Alias A']-----|
  |    [Initiate Friend Req] |
  |    [Listen to A']        |
  |                          |
  |<---- [Create Alias B'] --|
  |     [Accept Friend Req]  |
  |     [Update Friend List] |
  |     [Listen to B']       |
  |                          |
  |--- [Receive Acceptance] -|
  |    [Update Friend List]  |
  |                          |
  V                          V
[A' and B' for future chats]
```


- **Friend Request by A**: User A creates an alias, A', to initiate a friend request to User B. This alias is a temporary identity used to mask User A's real pubkey. A' then starts listening for incoming messages.

- **Friend Request Acceptance by B**: Upon receiving the friend request, User B creates an alias, B', for User A. B' is used to accept the friend request from A', at which point B' also updates the friend list to include A'. B' then starts listening for messages intended for it.

- **Friend List Update by A**: User A receives the friend request acceptance from B', updates their friend list to include B', thus establishing the communication channel.

- **Subsequent Communication**: Following these initial exchanges, all future messages between User A and User B are sent and received via their respective aliases, A' and B', ensuring that their real pubkeys are not exposed during their private conversation.





