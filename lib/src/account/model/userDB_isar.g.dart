// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUserDBISARCollection on Isar {
  IsarCollection<int, UserDBISAR> get userDBISARs => this.collection();
}

const UserDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'UserDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'pubKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'encryptedPrivKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'privkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'defaultPassword',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'nickName',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'mainRelay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'dns',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'lnurl',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'badges',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'gender',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'area',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'about',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'picture',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'banner',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'aliasPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'toAliasPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'toAliasPrivkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'friendsList',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'channelsList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'groupsList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'relayGroupsList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'badgesList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'blockedList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'blockedHashTags',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'blockedWords',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'blockedThreads',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'followingList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'followersList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'relayList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'dmRelayList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'inboxRelayList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'outboxRelayList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'lastFriendsListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastChannelsListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastGroupsListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastRelayGroupsListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastBadgesListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastBlockListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastRelayListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastFollowingListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastDMRelayListUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'mute',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'lastUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'otherField',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'nwcURI',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'remoteSignerURI',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'clientPrivateKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'remotePubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'encodedKeyPackage',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'keyPackageEventListJson',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'encodedKeyPackageJson',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'settings',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'pubKey',
        properties: [
          "pubKey",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, UserDBISAR>(
    serialize: serializeUserDBISAR,
    deserialize: deserializeUserDBISAR,
    deserializeProperty: deserializeUserDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeUserDBISAR(IsarWriter writer, UserDBISAR object) {
  IsarCore.writeString(writer, 1, object.pubKey);
  {
    final value = object.encryptedPrivKey;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  {
    final value = object.privkey;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  {
    final value = object.defaultPassword;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  {
    final value = object.name;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  {
    final value = object.nickName;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  {
    final value = object.mainRelay;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeString(writer, 7, value);
    }
  }
  {
    final value = object.dns;
    if (value == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      IsarCore.writeString(writer, 8, value);
    }
  }
  {
    final value = object.lnurl;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  {
    final value = object.badges;
    if (value == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      IsarCore.writeString(writer, 10, value);
    }
  }
  {
    final value = object.gender;
    if (value == null) {
      IsarCore.writeNull(writer, 11);
    } else {
      IsarCore.writeString(writer, 11, value);
    }
  }
  {
    final value = object.area;
    if (value == null) {
      IsarCore.writeNull(writer, 12);
    } else {
      IsarCore.writeString(writer, 12, value);
    }
  }
  {
    final value = object.about;
    if (value == null) {
      IsarCore.writeNull(writer, 13);
    } else {
      IsarCore.writeString(writer, 13, value);
    }
  }
  {
    final value = object.picture;
    if (value == null) {
      IsarCore.writeNull(writer, 14);
    } else {
      IsarCore.writeString(writer, 14, value);
    }
  }
  {
    final value = object.banner;
    if (value == null) {
      IsarCore.writeNull(writer, 15);
    } else {
      IsarCore.writeString(writer, 15, value);
    }
  }
  {
    final value = object.aliasPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 16);
    } else {
      IsarCore.writeString(writer, 16, value);
    }
  }
  {
    final value = object.toAliasPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 17);
    } else {
      IsarCore.writeString(writer, 17, value);
    }
  }
  {
    final value = object.toAliasPrivkey;
    if (value == null) {
      IsarCore.writeNull(writer, 18);
    } else {
      IsarCore.writeString(writer, 18, value);
    }
  }
  {
    final value = object.friendsList;
    if (value == null) {
      IsarCore.writeNull(writer, 19);
    } else {
      IsarCore.writeString(writer, 19, value);
    }
  }
  {
    final list = object.channelsList;
    if (list == null) {
      IsarCore.writeNull(writer, 20);
    } else {
      final listWriter = IsarCore.beginList(writer, 20, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.groupsList;
    if (list == null) {
      IsarCore.writeNull(writer, 21);
    } else {
      final listWriter = IsarCore.beginList(writer, 21, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.relayGroupsList;
    if (list == null) {
      IsarCore.writeNull(writer, 22);
    } else {
      final listWriter = IsarCore.beginList(writer, 22, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.badgesList;
    if (list == null) {
      IsarCore.writeNull(writer, 23);
    } else {
      final listWriter = IsarCore.beginList(writer, 23, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.blockedList;
    if (list == null) {
      IsarCore.writeNull(writer, 24);
    } else {
      final listWriter = IsarCore.beginList(writer, 24, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.blockedHashTags;
    if (list == null) {
      IsarCore.writeNull(writer, 25);
    } else {
      final listWriter = IsarCore.beginList(writer, 25, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.blockedWords;
    if (list == null) {
      IsarCore.writeNull(writer, 26);
    } else {
      final listWriter = IsarCore.beginList(writer, 26, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.blockedThreads;
    if (list == null) {
      IsarCore.writeNull(writer, 27);
    } else {
      final listWriter = IsarCore.beginList(writer, 27, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.followingList;
    if (list == null) {
      IsarCore.writeNull(writer, 28);
    } else {
      final listWriter = IsarCore.beginList(writer, 28, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.followersList;
    if (list == null) {
      IsarCore.writeNull(writer, 29);
    } else {
      final listWriter = IsarCore.beginList(writer, 29, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.relayList;
    if (list == null) {
      IsarCore.writeNull(writer, 30);
    } else {
      final listWriter = IsarCore.beginList(writer, 30, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.dmRelayList;
    if (list == null) {
      IsarCore.writeNull(writer, 31);
    } else {
      final listWriter = IsarCore.beginList(writer, 31, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.inboxRelayList;
    if (list == null) {
      IsarCore.writeNull(writer, 32);
    } else {
      final listWriter = IsarCore.beginList(writer, 32, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.outboxRelayList;
    if (list == null) {
      IsarCore.writeNull(writer, 33);
    } else {
      final listWriter = IsarCore.beginList(writer, 33, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeLong(writer, 34, object.lastFriendsListUpdatedTime);
  IsarCore.writeLong(writer, 35, object.lastChannelsListUpdatedTime);
  IsarCore.writeLong(writer, 36, object.lastGroupsListUpdatedTime);
  IsarCore.writeLong(writer, 37, object.lastRelayGroupsListUpdatedTime);
  IsarCore.writeLong(writer, 38, object.lastBadgesListUpdatedTime);
  IsarCore.writeLong(writer, 39, object.lastBlockListUpdatedTime);
  IsarCore.writeLong(writer, 40, object.lastRelayListUpdatedTime);
  IsarCore.writeLong(writer, 41, object.lastFollowingListUpdatedTime);
  IsarCore.writeLong(writer, 42, object.lastDMRelayListUpdatedTime);
  {
    final value = object.mute;
    if (value == null) {
      IsarCore.writeNull(writer, 43);
    } else {
      IsarCore.writeBool(writer, 43, value);
    }
  }
  IsarCore.writeLong(writer, 44, object.lastUpdatedTime);
  {
    final value = object.otherField;
    if (value == null) {
      IsarCore.writeNull(writer, 45);
    } else {
      IsarCore.writeString(writer, 45, value);
    }
  }
  {
    final value = object.nwcURI;
    if (value == null) {
      IsarCore.writeNull(writer, 46);
    } else {
      IsarCore.writeString(writer, 46, value);
    }
  }
  {
    final value = object.remoteSignerURI;
    if (value == null) {
      IsarCore.writeNull(writer, 47);
    } else {
      IsarCore.writeString(writer, 47, value);
    }
  }
  {
    final value = object.clientPrivateKey;
    if (value == null) {
      IsarCore.writeNull(writer, 48);
    } else {
      IsarCore.writeString(writer, 48, value);
    }
  }
  {
    final value = object.remotePubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 49);
    } else {
      IsarCore.writeString(writer, 49, value);
    }
  }
  {
    final value = object.encodedKeyPackage;
    if (value == null) {
      IsarCore.writeNull(writer, 50);
    } else {
      IsarCore.writeString(writer, 50, value);
    }
  }
  {
    final value = object.keyPackageEventListJson;
    if (value == null) {
      IsarCore.writeNull(writer, 51);
    } else {
      IsarCore.writeString(writer, 51, value);
    }
  }
  {
    final value = object.encodedKeyPackageJson;
    if (value == null) {
      IsarCore.writeNull(writer, 52);
    } else {
      IsarCore.writeString(writer, 52, value);
    }
  }
  {
    final value = object.settings;
    if (value == null) {
      IsarCore.writeNull(writer, 53);
    } else {
      IsarCore.writeString(writer, 53, value);
    }
  }
  return object.id;
}

@isarProtected
UserDBISAR deserializeUserDBISAR(IsarReader reader) {
  final String _pubKey;
  _pubKey = IsarCore.readString(reader, 1) ?? '';
  final String? _encryptedPrivKey;
  _encryptedPrivKey = IsarCore.readString(reader, 2) ?? '';
  final String? _privkey;
  _privkey = IsarCore.readString(reader, 3) ?? '';
  final String? _defaultPassword;
  _defaultPassword = IsarCore.readString(reader, 4) ?? '';
  final String? _name;
  _name = IsarCore.readString(reader, 5) ?? '';
  final String? _nickName;
  _nickName = IsarCore.readString(reader, 6) ?? '';
  final String? _mainRelay;
  _mainRelay = IsarCore.readString(reader, 7) ?? '';
  final String? _dns;
  _dns = IsarCore.readString(reader, 8) ?? '';
  final String? _lnurl;
  _lnurl = IsarCore.readString(reader, 9) ?? '';
  final String? _badges;
  _badges = IsarCore.readString(reader, 10) ?? '';
  final String? _gender;
  _gender = IsarCore.readString(reader, 11) ?? '';
  final String? _area;
  _area = IsarCore.readString(reader, 12) ?? '';
  final String? _about;
  _about = IsarCore.readString(reader, 13) ?? '';
  final String? _picture;
  _picture = IsarCore.readString(reader, 14) ?? '';
  final String? _banner;
  _banner = IsarCore.readString(reader, 15) ?? '';
  final String? _aliasPubkey;
  _aliasPubkey = IsarCore.readString(reader, 16) ?? '';
  final String? _toAliasPubkey;
  _toAliasPubkey = IsarCore.readString(reader, 17) ?? '';
  final String? _toAliasPrivkey;
  _toAliasPrivkey = IsarCore.readString(reader, 18) ?? '';
  final String? _friendsList;
  _friendsList = IsarCore.readString(reader, 19);
  final List<String>? _channelsList;
  {
    final length = IsarCore.readList(reader, 20, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _channelsList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _channelsList = list;
      }
    }
  }
  final List<String>? _groupsList;
  {
    final length = IsarCore.readList(reader, 21, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _groupsList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _groupsList = list;
      }
    }
  }
  final List<String>? _relayGroupsList;
  {
    final length = IsarCore.readList(reader, 22, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _relayGroupsList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _relayGroupsList = list;
      }
    }
  }
  final List<String>? _badgesList;
  {
    final length = IsarCore.readList(reader, 23, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _badgesList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _badgesList = list;
      }
    }
  }
  final List<String>? _blockedList;
  {
    final length = IsarCore.readList(reader, 24, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _blockedList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _blockedList = list;
      }
    }
  }
  final List<String>? _blockedHashTags;
  {
    final length = IsarCore.readList(reader, 25, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _blockedHashTags = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _blockedHashTags = list;
      }
    }
  }
  final List<String>? _blockedWords;
  {
    final length = IsarCore.readList(reader, 26, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _blockedWords = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _blockedWords = list;
      }
    }
  }
  final List<String>? _blockedThreads;
  {
    final length = IsarCore.readList(reader, 27, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _blockedThreads = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _blockedThreads = list;
      }
    }
  }
  final List<String>? _followingList;
  {
    final length = IsarCore.readList(reader, 28, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _followingList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _followingList = list;
      }
    }
  }
  final List<String>? _followersList;
  {
    final length = IsarCore.readList(reader, 29, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _followersList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _followersList = list;
      }
    }
  }
  final List<String>? _relayList;
  {
    final length = IsarCore.readList(reader, 30, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _relayList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _relayList = list;
      }
    }
  }
  final List<String>? _dmRelayList;
  {
    final length = IsarCore.readList(reader, 31, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _dmRelayList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _dmRelayList = list;
      }
    }
  }
  final List<String>? _inboxRelayList;
  {
    final length = IsarCore.readList(reader, 32, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _inboxRelayList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _inboxRelayList = list;
      }
    }
  }
  final List<String>? _outboxRelayList;
  {
    final length = IsarCore.readList(reader, 33, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _outboxRelayList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _outboxRelayList = list;
      }
    }
  }
  final int _lastFriendsListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 34);
    if (value == -9223372036854775808) {
      _lastFriendsListUpdatedTime = 0;
    } else {
      _lastFriendsListUpdatedTime = value;
    }
  }
  final int _lastChannelsListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 35);
    if (value == -9223372036854775808) {
      _lastChannelsListUpdatedTime = 0;
    } else {
      _lastChannelsListUpdatedTime = value;
    }
  }
  final int _lastGroupsListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 36);
    if (value == -9223372036854775808) {
      _lastGroupsListUpdatedTime = 0;
    } else {
      _lastGroupsListUpdatedTime = value;
    }
  }
  final int _lastRelayGroupsListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 37);
    if (value == -9223372036854775808) {
      _lastRelayGroupsListUpdatedTime = 0;
    } else {
      _lastRelayGroupsListUpdatedTime = value;
    }
  }
  final int _lastBadgesListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 38);
    if (value == -9223372036854775808) {
      _lastBadgesListUpdatedTime = 0;
    } else {
      _lastBadgesListUpdatedTime = value;
    }
  }
  final int _lastBlockListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 39);
    if (value == -9223372036854775808) {
      _lastBlockListUpdatedTime = 0;
    } else {
      _lastBlockListUpdatedTime = value;
    }
  }
  final int _lastRelayListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 40);
    if (value == -9223372036854775808) {
      _lastRelayListUpdatedTime = 0;
    } else {
      _lastRelayListUpdatedTime = value;
    }
  }
  final int _lastFollowingListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 41);
    if (value == -9223372036854775808) {
      _lastFollowingListUpdatedTime = 0;
    } else {
      _lastFollowingListUpdatedTime = value;
    }
  }
  final int _lastDMRelayListUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 42);
    if (value == -9223372036854775808) {
      _lastDMRelayListUpdatedTime = 0;
    } else {
      _lastDMRelayListUpdatedTime = value;
    }
  }
  final bool? _mute;
  _mute = IsarCore.readBool(reader, 43);
  final int _lastUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 44);
    if (value == -9223372036854775808) {
      _lastUpdatedTime = 0;
    } else {
      _lastUpdatedTime = value;
    }
  }
  final String? _otherField;
  _otherField = IsarCore.readString(reader, 45) ?? '{}';
  final String? _nwcURI;
  _nwcURI = IsarCore.readString(reader, 46);
  final String? _remoteSignerURI;
  _remoteSignerURI = IsarCore.readString(reader, 47);
  final String? _clientPrivateKey;
  _clientPrivateKey = IsarCore.readString(reader, 48);
  final String? _remotePubkey;
  _remotePubkey = IsarCore.readString(reader, 49);
  final String? _encodedKeyPackage;
  _encodedKeyPackage = IsarCore.readString(reader, 50);
  final String? _keyPackageEventListJson;
  _keyPackageEventListJson = IsarCore.readString(reader, 51);
  final String? _encodedKeyPackageJson;
  _encodedKeyPackageJson = IsarCore.readString(reader, 52);
  final String? _settings;
  _settings = IsarCore.readString(reader, 53);
  final object = UserDBISAR(
    pubKey: _pubKey,
    encryptedPrivKey: _encryptedPrivKey,
    privkey: _privkey,
    defaultPassword: _defaultPassword,
    name: _name,
    nickName: _nickName,
    mainRelay: _mainRelay,
    dns: _dns,
    lnurl: _lnurl,
    badges: _badges,
    gender: _gender,
    area: _area,
    about: _about,
    picture: _picture,
    banner: _banner,
    aliasPubkey: _aliasPubkey,
    toAliasPubkey: _toAliasPubkey,
    toAliasPrivkey: _toAliasPrivkey,
    friendsList: _friendsList,
    channelsList: _channelsList,
    groupsList: _groupsList,
    relayGroupsList: _relayGroupsList,
    badgesList: _badgesList,
    blockedList: _blockedList,
    blockedHashTags: _blockedHashTags,
    blockedWords: _blockedWords,
    blockedThreads: _blockedThreads,
    followingList: _followingList,
    followersList: _followersList,
    relayList: _relayList,
    dmRelayList: _dmRelayList,
    inboxRelayList: _inboxRelayList,
    outboxRelayList: _outboxRelayList,
    lastFriendsListUpdatedTime: _lastFriendsListUpdatedTime,
    lastChannelsListUpdatedTime: _lastChannelsListUpdatedTime,
    lastGroupsListUpdatedTime: _lastGroupsListUpdatedTime,
    lastRelayGroupsListUpdatedTime: _lastRelayGroupsListUpdatedTime,
    lastBadgesListUpdatedTime: _lastBadgesListUpdatedTime,
    lastBlockListUpdatedTime: _lastBlockListUpdatedTime,
    lastRelayListUpdatedTime: _lastRelayListUpdatedTime,
    lastFollowingListUpdatedTime: _lastFollowingListUpdatedTime,
    lastDMRelayListUpdatedTime: _lastDMRelayListUpdatedTime,
    mute: _mute,
    lastUpdatedTime: _lastUpdatedTime,
    otherField: _otherField,
    nwcURI: _nwcURI,
    remoteSignerURI: _remoteSignerURI,
    clientPrivateKey: _clientPrivateKey,
    remotePubkey: _remotePubkey,
    encodedKeyPackage: _encodedKeyPackage,
    keyPackageEventListJson: _keyPackageEventListJson,
    encodedKeyPackageJson: _encodedKeyPackageJson,
    settings: _settings,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeUserDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      return IsarCore.readString(reader, 8) ?? '';
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    case 10:
      return IsarCore.readString(reader, 10) ?? '';
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    case 12:
      return IsarCore.readString(reader, 12) ?? '';
    case 13:
      return IsarCore.readString(reader, 13) ?? '';
    case 14:
      return IsarCore.readString(reader, 14) ?? '';
    case 15:
      return IsarCore.readString(reader, 15) ?? '';
    case 16:
      return IsarCore.readString(reader, 16) ?? '';
    case 17:
      return IsarCore.readString(reader, 17) ?? '';
    case 18:
      return IsarCore.readString(reader, 18) ?? '';
    case 19:
      return IsarCore.readString(reader, 19);
    case 20:
      {
        final length = IsarCore.readList(reader, 20, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 21:
      {
        final length = IsarCore.readList(reader, 21, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 22:
      {
        final length = IsarCore.readList(reader, 22, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 23:
      {
        final length = IsarCore.readList(reader, 23, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 24:
      {
        final length = IsarCore.readList(reader, 24, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 25:
      {
        final length = IsarCore.readList(reader, 25, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 26:
      {
        final length = IsarCore.readList(reader, 26, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 27:
      {
        final length = IsarCore.readList(reader, 27, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 28:
      {
        final length = IsarCore.readList(reader, 28, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 29:
      {
        final length = IsarCore.readList(reader, 29, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 30:
      {
        final length = IsarCore.readList(reader, 30, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 31:
      {
        final length = IsarCore.readList(reader, 31, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 32:
      {
        final length = IsarCore.readList(reader, 32, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 33:
      {
        final length = IsarCore.readList(reader, 33, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 34:
      {
        final value = IsarCore.readLong(reader, 34);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 35:
      {
        final value = IsarCore.readLong(reader, 35);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 36:
      {
        final value = IsarCore.readLong(reader, 36);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 37:
      {
        final value = IsarCore.readLong(reader, 37);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 38:
      {
        final value = IsarCore.readLong(reader, 38);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 39:
      {
        final value = IsarCore.readLong(reader, 39);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 40:
      {
        final value = IsarCore.readLong(reader, 40);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 41:
      {
        final value = IsarCore.readLong(reader, 41);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 42:
      {
        final value = IsarCore.readLong(reader, 42);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 43:
      return IsarCore.readBool(reader, 43);
    case 44:
      {
        final value = IsarCore.readLong(reader, 44);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 45:
      return IsarCore.readString(reader, 45) ?? '{}';
    case 46:
      return IsarCore.readString(reader, 46);
    case 47:
      return IsarCore.readString(reader, 47);
    case 48:
      return IsarCore.readString(reader, 48);
    case 49:
      return IsarCore.readString(reader, 49);
    case 50:
      return IsarCore.readString(reader, 50);
    case 51:
      return IsarCore.readString(reader, 51);
    case 52:
      return IsarCore.readString(reader, 52);
    case 53:
      return IsarCore.readString(reader, 53);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _UserDBISARUpdate {
  bool call({
    required int id,
    String? pubKey,
    String? encryptedPrivKey,
    String? privkey,
    String? defaultPassword,
    String? name,
    String? nickName,
    String? mainRelay,
    String? dns,
    String? lnurl,
    String? badges,
    String? gender,
    String? area,
    String? about,
    String? picture,
    String? banner,
    String? aliasPubkey,
    String? toAliasPubkey,
    String? toAliasPrivkey,
    String? friendsList,
    int? lastFriendsListUpdatedTime,
    int? lastChannelsListUpdatedTime,
    int? lastGroupsListUpdatedTime,
    int? lastRelayGroupsListUpdatedTime,
    int? lastBadgesListUpdatedTime,
    int? lastBlockListUpdatedTime,
    int? lastRelayListUpdatedTime,
    int? lastFollowingListUpdatedTime,
    int? lastDMRelayListUpdatedTime,
    bool? mute,
    int? lastUpdatedTime,
    String? otherField,
    String? nwcURI,
    String? remoteSignerURI,
    String? clientPrivateKey,
    String? remotePubkey,
    String? encodedKeyPackage,
    String? keyPackageEventListJson,
    String? encodedKeyPackageJson,
    String? settings,
  });
}

class _UserDBISARUpdateImpl implements _UserDBISARUpdate {
  const _UserDBISARUpdateImpl(this.collection);

  final IsarCollection<int, UserDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? pubKey = ignore,
    Object? encryptedPrivKey = ignore,
    Object? privkey = ignore,
    Object? defaultPassword = ignore,
    Object? name = ignore,
    Object? nickName = ignore,
    Object? mainRelay = ignore,
    Object? dns = ignore,
    Object? lnurl = ignore,
    Object? badges = ignore,
    Object? gender = ignore,
    Object? area = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? banner = ignore,
    Object? aliasPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? toAliasPrivkey = ignore,
    Object? friendsList = ignore,
    Object? lastFriendsListUpdatedTime = ignore,
    Object? lastChannelsListUpdatedTime = ignore,
    Object? lastGroupsListUpdatedTime = ignore,
    Object? lastRelayGroupsListUpdatedTime = ignore,
    Object? lastBadgesListUpdatedTime = ignore,
    Object? lastBlockListUpdatedTime = ignore,
    Object? lastRelayListUpdatedTime = ignore,
    Object? lastFollowingListUpdatedTime = ignore,
    Object? lastDMRelayListUpdatedTime = ignore,
    Object? mute = ignore,
    Object? lastUpdatedTime = ignore,
    Object? otherField = ignore,
    Object? nwcURI = ignore,
    Object? remoteSignerURI = ignore,
    Object? clientPrivateKey = ignore,
    Object? remotePubkey = ignore,
    Object? encodedKeyPackage = ignore,
    Object? keyPackageEventListJson = ignore,
    Object? encodedKeyPackageJson = ignore,
    Object? settings = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (pubKey != ignore) 1: pubKey as String?,
          if (encryptedPrivKey != ignore) 2: encryptedPrivKey as String?,
          if (privkey != ignore) 3: privkey as String?,
          if (defaultPassword != ignore) 4: defaultPassword as String?,
          if (name != ignore) 5: name as String?,
          if (nickName != ignore) 6: nickName as String?,
          if (mainRelay != ignore) 7: mainRelay as String?,
          if (dns != ignore) 8: dns as String?,
          if (lnurl != ignore) 9: lnurl as String?,
          if (badges != ignore) 10: badges as String?,
          if (gender != ignore) 11: gender as String?,
          if (area != ignore) 12: area as String?,
          if (about != ignore) 13: about as String?,
          if (picture != ignore) 14: picture as String?,
          if (banner != ignore) 15: banner as String?,
          if (aliasPubkey != ignore) 16: aliasPubkey as String?,
          if (toAliasPubkey != ignore) 17: toAliasPubkey as String?,
          if (toAliasPrivkey != ignore) 18: toAliasPrivkey as String?,
          if (friendsList != ignore) 19: friendsList as String?,
          if (lastFriendsListUpdatedTime != ignore)
            34: lastFriendsListUpdatedTime as int?,
          if (lastChannelsListUpdatedTime != ignore)
            35: lastChannelsListUpdatedTime as int?,
          if (lastGroupsListUpdatedTime != ignore)
            36: lastGroupsListUpdatedTime as int?,
          if (lastRelayGroupsListUpdatedTime != ignore)
            37: lastRelayGroupsListUpdatedTime as int?,
          if (lastBadgesListUpdatedTime != ignore)
            38: lastBadgesListUpdatedTime as int?,
          if (lastBlockListUpdatedTime != ignore)
            39: lastBlockListUpdatedTime as int?,
          if (lastRelayListUpdatedTime != ignore)
            40: lastRelayListUpdatedTime as int?,
          if (lastFollowingListUpdatedTime != ignore)
            41: lastFollowingListUpdatedTime as int?,
          if (lastDMRelayListUpdatedTime != ignore)
            42: lastDMRelayListUpdatedTime as int?,
          if (mute != ignore) 43: mute as bool?,
          if (lastUpdatedTime != ignore) 44: lastUpdatedTime as int?,
          if (otherField != ignore) 45: otherField as String?,
          if (nwcURI != ignore) 46: nwcURI as String?,
          if (remoteSignerURI != ignore) 47: remoteSignerURI as String?,
          if (clientPrivateKey != ignore) 48: clientPrivateKey as String?,
          if (remotePubkey != ignore) 49: remotePubkey as String?,
          if (encodedKeyPackage != ignore) 50: encodedKeyPackage as String?,
          if (keyPackageEventListJson != ignore)
            51: keyPackageEventListJson as String?,
          if (encodedKeyPackageJson != ignore)
            52: encodedKeyPackageJson as String?,
          if (settings != ignore) 53: settings as String?,
        }) >
        0;
  }
}

sealed class _UserDBISARUpdateAll {
  int call({
    required List<int> id,
    String? pubKey,
    String? encryptedPrivKey,
    String? privkey,
    String? defaultPassword,
    String? name,
    String? nickName,
    String? mainRelay,
    String? dns,
    String? lnurl,
    String? badges,
    String? gender,
    String? area,
    String? about,
    String? picture,
    String? banner,
    String? aliasPubkey,
    String? toAliasPubkey,
    String? toAliasPrivkey,
    String? friendsList,
    int? lastFriendsListUpdatedTime,
    int? lastChannelsListUpdatedTime,
    int? lastGroupsListUpdatedTime,
    int? lastRelayGroupsListUpdatedTime,
    int? lastBadgesListUpdatedTime,
    int? lastBlockListUpdatedTime,
    int? lastRelayListUpdatedTime,
    int? lastFollowingListUpdatedTime,
    int? lastDMRelayListUpdatedTime,
    bool? mute,
    int? lastUpdatedTime,
    String? otherField,
    String? nwcURI,
    String? remoteSignerURI,
    String? clientPrivateKey,
    String? remotePubkey,
    String? encodedKeyPackage,
    String? keyPackageEventListJson,
    String? encodedKeyPackageJson,
    String? settings,
  });
}

class _UserDBISARUpdateAllImpl implements _UserDBISARUpdateAll {
  const _UserDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, UserDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? pubKey = ignore,
    Object? encryptedPrivKey = ignore,
    Object? privkey = ignore,
    Object? defaultPassword = ignore,
    Object? name = ignore,
    Object? nickName = ignore,
    Object? mainRelay = ignore,
    Object? dns = ignore,
    Object? lnurl = ignore,
    Object? badges = ignore,
    Object? gender = ignore,
    Object? area = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? banner = ignore,
    Object? aliasPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? toAliasPrivkey = ignore,
    Object? friendsList = ignore,
    Object? lastFriendsListUpdatedTime = ignore,
    Object? lastChannelsListUpdatedTime = ignore,
    Object? lastGroupsListUpdatedTime = ignore,
    Object? lastRelayGroupsListUpdatedTime = ignore,
    Object? lastBadgesListUpdatedTime = ignore,
    Object? lastBlockListUpdatedTime = ignore,
    Object? lastRelayListUpdatedTime = ignore,
    Object? lastFollowingListUpdatedTime = ignore,
    Object? lastDMRelayListUpdatedTime = ignore,
    Object? mute = ignore,
    Object? lastUpdatedTime = ignore,
    Object? otherField = ignore,
    Object? nwcURI = ignore,
    Object? remoteSignerURI = ignore,
    Object? clientPrivateKey = ignore,
    Object? remotePubkey = ignore,
    Object? encodedKeyPackage = ignore,
    Object? keyPackageEventListJson = ignore,
    Object? encodedKeyPackageJson = ignore,
    Object? settings = ignore,
  }) {
    return collection.updateProperties(id, {
      if (pubKey != ignore) 1: pubKey as String?,
      if (encryptedPrivKey != ignore) 2: encryptedPrivKey as String?,
      if (privkey != ignore) 3: privkey as String?,
      if (defaultPassword != ignore) 4: defaultPassword as String?,
      if (name != ignore) 5: name as String?,
      if (nickName != ignore) 6: nickName as String?,
      if (mainRelay != ignore) 7: mainRelay as String?,
      if (dns != ignore) 8: dns as String?,
      if (lnurl != ignore) 9: lnurl as String?,
      if (badges != ignore) 10: badges as String?,
      if (gender != ignore) 11: gender as String?,
      if (area != ignore) 12: area as String?,
      if (about != ignore) 13: about as String?,
      if (picture != ignore) 14: picture as String?,
      if (banner != ignore) 15: banner as String?,
      if (aliasPubkey != ignore) 16: aliasPubkey as String?,
      if (toAliasPubkey != ignore) 17: toAliasPubkey as String?,
      if (toAliasPrivkey != ignore) 18: toAliasPrivkey as String?,
      if (friendsList != ignore) 19: friendsList as String?,
      if (lastFriendsListUpdatedTime != ignore)
        34: lastFriendsListUpdatedTime as int?,
      if (lastChannelsListUpdatedTime != ignore)
        35: lastChannelsListUpdatedTime as int?,
      if (lastGroupsListUpdatedTime != ignore)
        36: lastGroupsListUpdatedTime as int?,
      if (lastRelayGroupsListUpdatedTime != ignore)
        37: lastRelayGroupsListUpdatedTime as int?,
      if (lastBadgesListUpdatedTime != ignore)
        38: lastBadgesListUpdatedTime as int?,
      if (lastBlockListUpdatedTime != ignore)
        39: lastBlockListUpdatedTime as int?,
      if (lastRelayListUpdatedTime != ignore)
        40: lastRelayListUpdatedTime as int?,
      if (lastFollowingListUpdatedTime != ignore)
        41: lastFollowingListUpdatedTime as int?,
      if (lastDMRelayListUpdatedTime != ignore)
        42: lastDMRelayListUpdatedTime as int?,
      if (mute != ignore) 43: mute as bool?,
      if (lastUpdatedTime != ignore) 44: lastUpdatedTime as int?,
      if (otherField != ignore) 45: otherField as String?,
      if (nwcURI != ignore) 46: nwcURI as String?,
      if (remoteSignerURI != ignore) 47: remoteSignerURI as String?,
      if (clientPrivateKey != ignore) 48: clientPrivateKey as String?,
      if (remotePubkey != ignore) 49: remotePubkey as String?,
      if (encodedKeyPackage != ignore) 50: encodedKeyPackage as String?,
      if (keyPackageEventListJson != ignore)
        51: keyPackageEventListJson as String?,
      if (encodedKeyPackageJson != ignore) 52: encodedKeyPackageJson as String?,
      if (settings != ignore) 53: settings as String?,
    });
  }
}

extension UserDBISARUpdate on IsarCollection<int, UserDBISAR> {
  _UserDBISARUpdate get update => _UserDBISARUpdateImpl(this);

  _UserDBISARUpdateAll get updateAll => _UserDBISARUpdateAllImpl(this);
}

sealed class _UserDBISARQueryUpdate {
  int call({
    String? pubKey,
    String? encryptedPrivKey,
    String? privkey,
    String? defaultPassword,
    String? name,
    String? nickName,
    String? mainRelay,
    String? dns,
    String? lnurl,
    String? badges,
    String? gender,
    String? area,
    String? about,
    String? picture,
    String? banner,
    String? aliasPubkey,
    String? toAliasPubkey,
    String? toAliasPrivkey,
    String? friendsList,
    int? lastFriendsListUpdatedTime,
    int? lastChannelsListUpdatedTime,
    int? lastGroupsListUpdatedTime,
    int? lastRelayGroupsListUpdatedTime,
    int? lastBadgesListUpdatedTime,
    int? lastBlockListUpdatedTime,
    int? lastRelayListUpdatedTime,
    int? lastFollowingListUpdatedTime,
    int? lastDMRelayListUpdatedTime,
    bool? mute,
    int? lastUpdatedTime,
    String? otherField,
    String? nwcURI,
    String? remoteSignerURI,
    String? clientPrivateKey,
    String? remotePubkey,
    String? encodedKeyPackage,
    String? keyPackageEventListJson,
    String? encodedKeyPackageJson,
    String? settings,
  });
}

class _UserDBISARQueryUpdateImpl implements _UserDBISARQueryUpdate {
  const _UserDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<UserDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? pubKey = ignore,
    Object? encryptedPrivKey = ignore,
    Object? privkey = ignore,
    Object? defaultPassword = ignore,
    Object? name = ignore,
    Object? nickName = ignore,
    Object? mainRelay = ignore,
    Object? dns = ignore,
    Object? lnurl = ignore,
    Object? badges = ignore,
    Object? gender = ignore,
    Object? area = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? banner = ignore,
    Object? aliasPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? toAliasPrivkey = ignore,
    Object? friendsList = ignore,
    Object? lastFriendsListUpdatedTime = ignore,
    Object? lastChannelsListUpdatedTime = ignore,
    Object? lastGroupsListUpdatedTime = ignore,
    Object? lastRelayGroupsListUpdatedTime = ignore,
    Object? lastBadgesListUpdatedTime = ignore,
    Object? lastBlockListUpdatedTime = ignore,
    Object? lastRelayListUpdatedTime = ignore,
    Object? lastFollowingListUpdatedTime = ignore,
    Object? lastDMRelayListUpdatedTime = ignore,
    Object? mute = ignore,
    Object? lastUpdatedTime = ignore,
    Object? otherField = ignore,
    Object? nwcURI = ignore,
    Object? remoteSignerURI = ignore,
    Object? clientPrivateKey = ignore,
    Object? remotePubkey = ignore,
    Object? encodedKeyPackage = ignore,
    Object? keyPackageEventListJson = ignore,
    Object? encodedKeyPackageJson = ignore,
    Object? settings = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (pubKey != ignore) 1: pubKey as String?,
      if (encryptedPrivKey != ignore) 2: encryptedPrivKey as String?,
      if (privkey != ignore) 3: privkey as String?,
      if (defaultPassword != ignore) 4: defaultPassword as String?,
      if (name != ignore) 5: name as String?,
      if (nickName != ignore) 6: nickName as String?,
      if (mainRelay != ignore) 7: mainRelay as String?,
      if (dns != ignore) 8: dns as String?,
      if (lnurl != ignore) 9: lnurl as String?,
      if (badges != ignore) 10: badges as String?,
      if (gender != ignore) 11: gender as String?,
      if (area != ignore) 12: area as String?,
      if (about != ignore) 13: about as String?,
      if (picture != ignore) 14: picture as String?,
      if (banner != ignore) 15: banner as String?,
      if (aliasPubkey != ignore) 16: aliasPubkey as String?,
      if (toAliasPubkey != ignore) 17: toAliasPubkey as String?,
      if (toAliasPrivkey != ignore) 18: toAliasPrivkey as String?,
      if (friendsList != ignore) 19: friendsList as String?,
      if (lastFriendsListUpdatedTime != ignore)
        34: lastFriendsListUpdatedTime as int?,
      if (lastChannelsListUpdatedTime != ignore)
        35: lastChannelsListUpdatedTime as int?,
      if (lastGroupsListUpdatedTime != ignore)
        36: lastGroupsListUpdatedTime as int?,
      if (lastRelayGroupsListUpdatedTime != ignore)
        37: lastRelayGroupsListUpdatedTime as int?,
      if (lastBadgesListUpdatedTime != ignore)
        38: lastBadgesListUpdatedTime as int?,
      if (lastBlockListUpdatedTime != ignore)
        39: lastBlockListUpdatedTime as int?,
      if (lastRelayListUpdatedTime != ignore)
        40: lastRelayListUpdatedTime as int?,
      if (lastFollowingListUpdatedTime != ignore)
        41: lastFollowingListUpdatedTime as int?,
      if (lastDMRelayListUpdatedTime != ignore)
        42: lastDMRelayListUpdatedTime as int?,
      if (mute != ignore) 43: mute as bool?,
      if (lastUpdatedTime != ignore) 44: lastUpdatedTime as int?,
      if (otherField != ignore) 45: otherField as String?,
      if (nwcURI != ignore) 46: nwcURI as String?,
      if (remoteSignerURI != ignore) 47: remoteSignerURI as String?,
      if (clientPrivateKey != ignore) 48: clientPrivateKey as String?,
      if (remotePubkey != ignore) 49: remotePubkey as String?,
      if (encodedKeyPackage != ignore) 50: encodedKeyPackage as String?,
      if (keyPackageEventListJson != ignore)
        51: keyPackageEventListJson as String?,
      if (encodedKeyPackageJson != ignore) 52: encodedKeyPackageJson as String?,
      if (settings != ignore) 53: settings as String?,
    });
  }
}

extension UserDBISARQueryUpdate on IsarQuery<UserDBISAR> {
  _UserDBISARQueryUpdate get updateFirst =>
      _UserDBISARQueryUpdateImpl(this, limit: 1);

  _UserDBISARQueryUpdate get updateAll => _UserDBISARQueryUpdateImpl(this);
}

class _UserDBISARQueryBuilderUpdateImpl implements _UserDBISARQueryUpdate {
  const _UserDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<UserDBISAR, UserDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? pubKey = ignore,
    Object? encryptedPrivKey = ignore,
    Object? privkey = ignore,
    Object? defaultPassword = ignore,
    Object? name = ignore,
    Object? nickName = ignore,
    Object? mainRelay = ignore,
    Object? dns = ignore,
    Object? lnurl = ignore,
    Object? badges = ignore,
    Object? gender = ignore,
    Object? area = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? banner = ignore,
    Object? aliasPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? toAliasPrivkey = ignore,
    Object? friendsList = ignore,
    Object? lastFriendsListUpdatedTime = ignore,
    Object? lastChannelsListUpdatedTime = ignore,
    Object? lastGroupsListUpdatedTime = ignore,
    Object? lastRelayGroupsListUpdatedTime = ignore,
    Object? lastBadgesListUpdatedTime = ignore,
    Object? lastBlockListUpdatedTime = ignore,
    Object? lastRelayListUpdatedTime = ignore,
    Object? lastFollowingListUpdatedTime = ignore,
    Object? lastDMRelayListUpdatedTime = ignore,
    Object? mute = ignore,
    Object? lastUpdatedTime = ignore,
    Object? otherField = ignore,
    Object? nwcURI = ignore,
    Object? remoteSignerURI = ignore,
    Object? clientPrivateKey = ignore,
    Object? remotePubkey = ignore,
    Object? encodedKeyPackage = ignore,
    Object? keyPackageEventListJson = ignore,
    Object? encodedKeyPackageJson = ignore,
    Object? settings = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (pubKey != ignore) 1: pubKey as String?,
        if (encryptedPrivKey != ignore) 2: encryptedPrivKey as String?,
        if (privkey != ignore) 3: privkey as String?,
        if (defaultPassword != ignore) 4: defaultPassword as String?,
        if (name != ignore) 5: name as String?,
        if (nickName != ignore) 6: nickName as String?,
        if (mainRelay != ignore) 7: mainRelay as String?,
        if (dns != ignore) 8: dns as String?,
        if (lnurl != ignore) 9: lnurl as String?,
        if (badges != ignore) 10: badges as String?,
        if (gender != ignore) 11: gender as String?,
        if (area != ignore) 12: area as String?,
        if (about != ignore) 13: about as String?,
        if (picture != ignore) 14: picture as String?,
        if (banner != ignore) 15: banner as String?,
        if (aliasPubkey != ignore) 16: aliasPubkey as String?,
        if (toAliasPubkey != ignore) 17: toAliasPubkey as String?,
        if (toAliasPrivkey != ignore) 18: toAliasPrivkey as String?,
        if (friendsList != ignore) 19: friendsList as String?,
        if (lastFriendsListUpdatedTime != ignore)
          34: lastFriendsListUpdatedTime as int?,
        if (lastChannelsListUpdatedTime != ignore)
          35: lastChannelsListUpdatedTime as int?,
        if (lastGroupsListUpdatedTime != ignore)
          36: lastGroupsListUpdatedTime as int?,
        if (lastRelayGroupsListUpdatedTime != ignore)
          37: lastRelayGroupsListUpdatedTime as int?,
        if (lastBadgesListUpdatedTime != ignore)
          38: lastBadgesListUpdatedTime as int?,
        if (lastBlockListUpdatedTime != ignore)
          39: lastBlockListUpdatedTime as int?,
        if (lastRelayListUpdatedTime != ignore)
          40: lastRelayListUpdatedTime as int?,
        if (lastFollowingListUpdatedTime != ignore)
          41: lastFollowingListUpdatedTime as int?,
        if (lastDMRelayListUpdatedTime != ignore)
          42: lastDMRelayListUpdatedTime as int?,
        if (mute != ignore) 43: mute as bool?,
        if (lastUpdatedTime != ignore) 44: lastUpdatedTime as int?,
        if (otherField != ignore) 45: otherField as String?,
        if (nwcURI != ignore) 46: nwcURI as String?,
        if (remoteSignerURI != ignore) 47: remoteSignerURI as String?,
        if (clientPrivateKey != ignore) 48: clientPrivateKey as String?,
        if (remotePubkey != ignore) 49: remotePubkey as String?,
        if (encodedKeyPackage != ignore) 50: encodedKeyPackage as String?,
        if (keyPackageEventListJson != ignore)
          51: keyPackageEventListJson as String?,
        if (encodedKeyPackageJson != ignore)
          52: encodedKeyPackageJson as String?,
        if (settings != ignore) 53: settings as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension UserDBISARQueryBuilderUpdate
    on QueryBuilder<UserDBISAR, UserDBISAR, QOperations> {
  _UserDBISARQueryUpdate get updateFirst =>
      _UserDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _UserDBISARQueryUpdate get updateAll =>
      _UserDBISARQueryBuilderUpdateImpl(this);
}

extension UserDBISARQueryFilter
    on QueryBuilder<UserDBISAR, UserDBISAR, QFilterCondition> {
  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pubKeyGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pubKeyLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pubKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pubKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encryptedPrivKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      privkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      privkeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      privkeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      privkeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> privkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      privkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      defaultPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nickNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nickNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> mainRelayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> mainRelayLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> mainRelayBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> mainRelayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> mainRelayContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> mainRelayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      mainRelayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dnsGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dnsLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 8,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> dnsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lnurlGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lnurlLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> lnurlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lnurlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> badgesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      genderIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      genderGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      genderLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 11,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      areaGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      areaLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 12,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 12,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> areaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aboutGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aboutLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 13,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 13,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> aboutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aboutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pictureIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pictureGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pictureGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pictureLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 14,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> pictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      pictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      bannerIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      bannerGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      bannerLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 15,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 15,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> bannerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      bannerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 16,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 16,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      aliasPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 17,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 17,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 18));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 18));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 18,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 18,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 18,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      toAliasPrivkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 18,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 19));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 19));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 19,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 19,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      friendsListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 20));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 20));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 20,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 20,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 20,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 20,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListIsEmpty() {
    return not().group(
      (q) => q.channelsListIsNull().or().channelsListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      channelsListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 20, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 21));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 21));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 21,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 21,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 21,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 21,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListIsEmpty() {
    return not().group(
      (q) => q.groupsListIsNull().or().groupsListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      groupsListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 21, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 22));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 22));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 22,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 22,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 22,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 22,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListIsEmpty() {
    return not().group(
      (q) => q.relayGroupsListIsNull().or().relayGroupsListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayGroupsListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 22, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 23));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 23));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 23,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 23,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 23,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 23,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListIsEmpty() {
    return not().group(
      (q) => q.badgesListIsNull().or().badgesListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      badgesListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 23, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 24));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 24));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 24,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 24,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 24,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 24,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListIsEmpty() {
    return not().group(
      (q) => q.blockedListIsNull().or().blockedListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 24, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 25));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 25));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 25,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 25,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 25,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 25,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsIsEmpty() {
    return not().group(
      (q) => q.blockedHashTagsIsNull().or().blockedHashTagsIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedHashTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 25, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 26));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 26));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 26,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 26,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 26,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 26,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 26,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsIsEmpty() {
    return not().group(
      (q) => q.blockedWordsIsNull().or().blockedWordsIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 26, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 27));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 27));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 27,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 27,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 27,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 27,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 27,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsIsEmpty() {
    return not().group(
      (q) => q.blockedThreadsIsNull().or().blockedThreadsIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      blockedThreadsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 27, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 28));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 28));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 28,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 28,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 28,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 28,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 28,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListIsEmpty() {
    return not().group(
      (q) => q.followingListIsNull().or().followingListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followingListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 28, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 29));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 29));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 29,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 29,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 29,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 29,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 29,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListIsEmpty() {
    return not().group(
      (q) => q.followersListIsNull().or().followersListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      followersListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 29, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 30));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 30));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 30,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 30,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 30,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 30,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 30,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListIsEmpty() {
    return not().group(
      (q) => q.relayListIsNull().or().relayListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      relayListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 30, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 31));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 31));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 31,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 31,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 31,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 31,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 31,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListIsEmpty() {
    return not().group(
      (q) => q.dmRelayListIsNull().or().dmRelayListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      dmRelayListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 31, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 32));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 32));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 32,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 32,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 32,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 32,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 32,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListIsEmpty() {
    return not().group(
      (q) => q.inboxRelayListIsNull().or().inboxRelayListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      inboxRelayListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 32, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 33));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 33));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 33,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 33,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 33,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 33,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 33,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListIsEmpty() {
    return not().group(
      (q) => q.outboxRelayListIsNull().or().outboxRelayListIsNotEmpty(),
    );
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      outboxRelayListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 33, value: null),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFriendsListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFriendsListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFriendsListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFriendsListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFriendsListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFriendsListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 34,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastChannelsListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 35,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastChannelsListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 35,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastChannelsListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 35,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastChannelsListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 35,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastChannelsListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 35,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastChannelsListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 35,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastGroupsListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 36,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastGroupsListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 36,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastGroupsListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 36,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastGroupsListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 36,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastGroupsListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 36,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastGroupsListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 36,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayGroupsListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 37,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayGroupsListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 37,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayGroupsListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 37,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayGroupsListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 37,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayGroupsListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 37,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayGroupsListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 37,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBadgesListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 38,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBadgesListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 38,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBadgesListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 38,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBadgesListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 38,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBadgesListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 38,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBadgesListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 38,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBlockListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 39,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBlockListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 39,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBlockListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 39,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBlockListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 39,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBlockListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 39,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastBlockListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 39,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 40,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 40,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 40,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 40,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 40,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastRelayListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 40,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFollowingListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 41,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFollowingListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 41,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFollowingListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 41,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFollowingListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 41,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFollowingListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 41,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastFollowingListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 41,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastDMRelayListUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 42,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastDMRelayListUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 42,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastDMRelayListUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 42,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastDMRelayListUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 42,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastDMRelayListUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 42,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastDMRelayListUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 42,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> muteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 43));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> muteIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 43));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> muteEqualTo(
    bool? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 43,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 44,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 44,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 44,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 44,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 44,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      lastUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 44,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 45));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 45));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> otherFieldEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> otherFieldBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 45,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 45,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> otherFieldMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 45,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 45,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      otherFieldIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 45,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 46));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nwcURIIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 46));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nwcURIGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURILessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nwcURILessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 46,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 46,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 46,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> nwcURIIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 46,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      nwcURIIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 46,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 47));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 47));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURILessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURILessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 47,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 47,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 47,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 47,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remoteSignerURIIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 47,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 48));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 48));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 48,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 48,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 48,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 48,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      clientPrivateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 48,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 49));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 49));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 49,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 49,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 49,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 49,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      remotePubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 49,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 50));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 50));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 50,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 50,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 50,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 50,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 50,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 51));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 51));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 51,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 51,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 51,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 51,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      keyPackageEventListJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 51,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 52));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 52));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 52,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 52,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 52,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 52,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      encodedKeyPackageJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 52,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 53));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 53));
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 53,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 53,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition> settingsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 53,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 53,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterFilterCondition>
      settingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 53,
          value: '',
        ),
      );
    });
  }
}

extension UserDBISARQueryObject
    on QueryBuilder<UserDBISAR, UserDBISAR, QFilterCondition> {}

extension UserDBISARQuerySortBy
    on QueryBuilder<UserDBISAR, UserDBISAR, QSortBy> {
  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByPubKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByPubKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByEncryptedPrivKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByEncryptedPrivKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByPrivkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByPrivkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByDefaultPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByDefaultPasswordDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByNickName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByNickNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByMainRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByMainRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByDns(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByDnsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByLnurl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByLnurlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByBadges(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByBadgesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByGenderDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByArea(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByAreaDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByAboutDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByPictureDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByBanner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        15,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByBannerDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        15,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByAliasPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByAliasPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByToAliasPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByToAliasPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByToAliasPrivkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        18,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByToAliasPrivkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        18,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByFriendsList(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByFriendsListDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastFriendsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastFriendsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastChannelsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(35);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastChannelsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(35, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastGroupsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(36);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastGroupsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(36, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastRelayGroupsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(37);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastRelayGroupsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(37, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastBadgesListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(38);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastBadgesListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(38, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastBlockListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(39);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastBlockListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(39, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastRelayListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(40);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastRelayListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(40, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastFollowingListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(41);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastFollowingListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(41, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastDMRelayListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(42);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastDMRelayListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(42, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(43);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(43, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(44);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByLastUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(44, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByOtherField(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        45,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByOtherFieldDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        45,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByNwcURI(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        46,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByNwcURIDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        46,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByRemoteSignerURI(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        47,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByRemoteSignerURIDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        47,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByClientPrivateKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        48,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByClientPrivateKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        48,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByRemotePubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        49,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByRemotePubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        49,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortByEncodedKeyPackage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        50,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByEncodedKeyPackageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        50,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByKeyPackageEventListJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        51,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByKeyPackageEventListJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        51,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByEncodedKeyPackageJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        52,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      sortByEncodedKeyPackageJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        52,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortBySettings(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        53,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> sortBySettingsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        53,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension UserDBISARQuerySortThenBy
    on QueryBuilder<UserDBISAR, UserDBISAR, QSortThenBy> {
  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByPubKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByPubKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByEncryptedPrivKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByEncryptedPrivKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByPrivkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByPrivkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByDefaultPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByDefaultPasswordDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByNickName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByNickNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByMainRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByMainRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByDns(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByDnsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByLnurl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByLnurlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByBadges(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByBadgesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByGenderDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByArea(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByAreaDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByAboutDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByPictureDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByBanner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByBannerDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByAliasPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByAliasPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByToAliasPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByToAliasPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByToAliasPrivkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByToAliasPrivkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByFriendsList(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByFriendsListDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastFriendsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastFriendsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastChannelsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(35);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastChannelsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(35, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastGroupsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(36);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastGroupsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(36, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastRelayGroupsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(37);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastRelayGroupsListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(37, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastBadgesListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(38);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastBadgesListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(38, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastBlockListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(39);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastBlockListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(39, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastRelayListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(40);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastRelayListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(40, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastFollowingListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(41);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastFollowingListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(41, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastDMRelayListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(42);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastDMRelayListUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(42, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(43);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(43, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(44);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByLastUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(44, sort: Sort.desc);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByOtherField(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(45, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByOtherFieldDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(45, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByNwcURI(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(46, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByNwcURIDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(46, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByRemoteSignerURI(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(47, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByRemoteSignerURIDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(47, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByClientPrivateKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(48, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByClientPrivateKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(48, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByRemotePubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(49, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByRemotePubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(49, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenByEncodedKeyPackage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(50, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByEncodedKeyPackageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(50, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByKeyPackageEventListJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(51, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByKeyPackageEventListJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(51, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByEncodedKeyPackageJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(52, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy>
      thenByEncodedKeyPackageJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(52, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenBySettings(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(53, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterSortBy> thenBySettingsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(53, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension UserDBISARQueryWhereDistinct
    on QueryBuilder<UserDBISAR, UserDBISAR, QDistinct> {
  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByPubKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByEncryptedPrivKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByPrivkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByDefaultPassword({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByNickName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByMainRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByDns(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByLnurl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByBadges(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByArea(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByBanner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByAliasPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByToAliasPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByToAliasPrivkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByFriendsList(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByChannelsList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(20);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByGroupsList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(21);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByRelayGroupsList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(22);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByBadgesList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(23);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByBlockedList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(24);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByBlockedHashTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(25);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByBlockedWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(26);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByBlockedThreads() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(27);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByFollowingList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(28);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByFollowersList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(29);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByRelayList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(30);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByDmRelayList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(31);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByInboxRelayList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(32);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByOutboxRelayList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(33);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastFriendsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(34);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastChannelsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(35);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastGroupsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(36);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastRelayGroupsListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(37);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastBadgesListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(38);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastBlockListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(39);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastRelayListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(40);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastFollowingListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(41);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastDMRelayListUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(42);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(43);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(44);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByOtherField(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(45, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByNwcURI(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(46, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByRemoteSignerURI({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(47, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByClientPrivateKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(48, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctByRemotePubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(49, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByEncodedKeyPackage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(50, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByKeyPackageEventListJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(51, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct>
      distinctByEncodedKeyPackageJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(52, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserDBISAR, UserDBISAR, QAfterDistinct> distinctBySettings(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(53, caseSensitive: caseSensitive);
    });
  }
}

extension UserDBISARQueryProperty1
    on QueryBuilder<UserDBISAR, UserDBISAR, QProperty> {
  QueryBuilder<UserDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserDBISAR, String, QAfterProperty> pubKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> encryptedPrivKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> privkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> defaultPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> nickNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> mainRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> dnsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> lnurlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> areaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> bannerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> aliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> toAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> toAliasPrivkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> friendsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      channelsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty> groupsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      relayGroupsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty> badgesListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      blockedListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      blockedHashTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      blockedWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      blockedThreadsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      followingListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      followersListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty> relayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(30);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      dmRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(31);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      inboxRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(32);
    });
  }

  QueryBuilder<UserDBISAR, List<String>?, QAfterProperty>
      outboxRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(33);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastFriendsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(34);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastChannelsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(35);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastGroupsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(36);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastRelayGroupsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(37);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastBadgesListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(38);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastBlockListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(39);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastRelayListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(40);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastFollowingListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(41);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty>
      lastDMRelayListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(42);
    });
  }

  QueryBuilder<UserDBISAR, bool?, QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(43);
    });
  }

  QueryBuilder<UserDBISAR, int, QAfterProperty> lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(44);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> otherFieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(45);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> nwcURIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(46);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> remoteSignerURIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(47);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> clientPrivateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(48);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> remotePubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(49);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty>
      encodedKeyPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(50);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty>
      keyPackageEventListJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(51);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty>
      encodedKeyPackageJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(52);
    });
  }

  QueryBuilder<UserDBISAR, String?, QAfterProperty> settingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(53);
    });
  }
}

extension UserDBISARQueryProperty2<R>
    on QueryBuilder<UserDBISAR, R, QAfterProperty> {
  QueryBuilder<UserDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserDBISAR, (R, String), QAfterProperty> pubKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      encryptedPrivKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> privkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      defaultPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> nickNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> mainRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> dnsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> lnurlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> areaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> bannerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> aliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      toAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      toAliasPrivkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> friendsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      channelsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      groupsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      relayGroupsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      badgesListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      blockedListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      blockedHashTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      blockedWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      blockedThreadsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      followingListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      followersListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      relayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(30);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      dmRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(31);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      inboxRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(32);
    });
  }

  QueryBuilder<UserDBISAR, (R, List<String>?), QAfterProperty>
      outboxRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(33);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastFriendsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(34);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastChannelsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(35);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastGroupsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(36);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastRelayGroupsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(37);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastBadgesListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(38);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastBlockListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(39);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastRelayListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(40);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastFollowingListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(41);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty>
      lastDMRelayListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(42);
    });
  }

  QueryBuilder<UserDBISAR, (R, bool?), QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(43);
    });
  }

  QueryBuilder<UserDBISAR, (R, int), QAfterProperty> lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(44);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> otherFieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(45);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> nwcURIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(46);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      remoteSignerURIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(47);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      clientPrivateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(48);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      remotePubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(49);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      encodedKeyPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(50);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      keyPackageEventListJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(51);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty>
      encodedKeyPackageJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(52);
    });
  }

  QueryBuilder<UserDBISAR, (R, String?), QAfterProperty> settingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(53);
    });
  }
}

extension UserDBISARQueryProperty3<R1, R2>
    on QueryBuilder<UserDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String), QOperations> pubKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      encryptedPrivKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> privkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      defaultPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> nickNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> mainRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> dnsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> lnurlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> areaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> bannerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      aliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      toAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      toAliasPrivkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      friendsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      channelsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      groupsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      relayGroupsListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      badgesListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      blockedListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      blockedHashTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      blockedWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      blockedThreadsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      followingListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      followersListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      relayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(30);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      dmRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(31);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      inboxRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(32);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, List<String>?), QOperations>
      outboxRelayListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(33);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastFriendsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(34);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastChannelsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(35);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastGroupsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(36);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastRelayGroupsListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(37);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastBadgesListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(38);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastBlockListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(39);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastRelayListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(40);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastFollowingListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(41);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastDMRelayListUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(42);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, bool?), QOperations> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(43);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, int), QOperations>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(44);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      otherFieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(45);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> nwcURIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(46);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      remoteSignerURIProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(47);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      clientPrivateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(48);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      remotePubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(49);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      encodedKeyPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(50);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      keyPackageEventListJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(51);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations>
      encodedKeyPackageJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(52);
    });
  }

  QueryBuilder<UserDBISAR, (R1, R2, String?), QOperations> settingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(53);
    });
  }
}
