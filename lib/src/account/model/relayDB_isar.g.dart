// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetRelayDBISARCollection on Isar {
  IsarCollection<int, RelayDBISAR> get relayDBISARs => this.collection();
}

const RelayDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'RelayDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'url',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'pubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'description',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'contact',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'supportedNips',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'supportedNipExtensions',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'software',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'version',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'limitation',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'paymentsUrl',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'fees',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'icon',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'friendRequestSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'friendRequestUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'friendMessageSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'friendMessageUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'channelMessageSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'channelMessageUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'commonMessagesSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'commonMessagesUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'groupMessageSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'groupMessageUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'mlsGroupMessageSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'mlsGroupMessageUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'momentSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'momentUntil',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapRecordSince',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapRecordUntil',
        type: IsarType.long,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'url',
        properties: [
          "url",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, RelayDBISAR>(
    serialize: serializeRelayDBISAR,
    deserialize: deserializeRelayDBISAR,
    deserializeProperty: deserializeRelayDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeRelayDBISAR(IsarWriter writer, RelayDBISAR object) {
  IsarCore.writeString(writer, 1, object.url);
  {
    final value = object.name;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  {
    final value = object.pubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  {
    final value = object.description;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  {
    final value = object.contact;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  {
    final value = object.supportedNips;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  {
    final value = object.supportedNipExtensions;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeString(writer, 7, value);
    }
  }
  {
    final value = object.software;
    if (value == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      IsarCore.writeString(writer, 8, value);
    }
  }
  {
    final value = object.version;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  {
    final value = object.limitation;
    if (value == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      IsarCore.writeString(writer, 10, value);
    }
  }
  {
    final value = object.paymentsUrl;
    if (value == null) {
      IsarCore.writeNull(writer, 11);
    } else {
      IsarCore.writeString(writer, 11, value);
    }
  }
  {
    final value = object.fees;
    if (value == null) {
      IsarCore.writeNull(writer, 12);
    } else {
      IsarCore.writeString(writer, 12, value);
    }
  }
  {
    final value = object.icon;
    if (value == null) {
      IsarCore.writeNull(writer, 13);
    } else {
      IsarCore.writeString(writer, 13, value);
    }
  }
  IsarCore.writeLong(writer, 14, object.friendRequestSince);
  IsarCore.writeLong(writer, 15, object.friendRequestUntil);
  IsarCore.writeLong(writer, 16, object.friendMessageSince);
  IsarCore.writeLong(writer, 17, object.friendMessageUntil);
  IsarCore.writeLong(writer, 18, object.channelMessageSince);
  IsarCore.writeLong(writer, 19, object.channelMessageUntil);
  IsarCore.writeLong(writer, 20, object.commonMessagesSince);
  IsarCore.writeLong(writer, 21, object.commonMessagesUntil);
  IsarCore.writeLong(writer, 22, object.groupMessageSince);
  IsarCore.writeLong(writer, 23, object.groupMessageUntil);
  IsarCore.writeLong(writer, 24, object.mlsGroupMessageSince);
  IsarCore.writeLong(writer, 25, object.mlsGroupMessageUntil);
  IsarCore.writeLong(writer, 26, object.momentSince);
  IsarCore.writeLong(writer, 27, object.momentUntil);
  IsarCore.writeLong(writer, 28, object.zapRecordSince);
  IsarCore.writeLong(writer, 29, object.zapRecordUntil);
  return object.id;
}

@isarProtected
RelayDBISAR deserializeRelayDBISAR(IsarReader reader) {
  final String _url;
  _url = IsarCore.readString(reader, 1) ?? '';
  final String? _pubkey;
  _pubkey = IsarCore.readString(reader, 3) ?? '';
  final String? _description;
  _description = IsarCore.readString(reader, 4) ?? '';
  final String? _contact;
  _contact = IsarCore.readString(reader, 5) ?? '';
  final String? _supportedNips;
  _supportedNips = IsarCore.readString(reader, 6) ?? '';
  final String? _supportedNipExtensions;
  _supportedNipExtensions = IsarCore.readString(reader, 7) ?? '';
  final String? _software;
  _software = IsarCore.readString(reader, 8) ?? '';
  final String? _version;
  _version = IsarCore.readString(reader, 9) ?? '';
  final String? _limitation;
  _limitation = IsarCore.readString(reader, 10) ?? '';
  final String? _paymentsUrl;
  _paymentsUrl = IsarCore.readString(reader, 11) ?? '';
  final String? _fees;
  _fees = IsarCore.readString(reader, 12) ?? '';
  final String? _icon;
  _icon = IsarCore.readString(reader, 13) ?? '';
  final int _friendRequestSince;
  {
    final value = IsarCore.readLong(reader, 14);
    if (value == -9223372036854775808) {
      _friendRequestSince = 0;
    } else {
      _friendRequestSince = value;
    }
  }
  final int _friendRequestUntil;
  {
    final value = IsarCore.readLong(reader, 15);
    if (value == -9223372036854775808) {
      _friendRequestUntil = 0;
    } else {
      _friendRequestUntil = value;
    }
  }
  final int _friendMessageSince;
  {
    final value = IsarCore.readLong(reader, 16);
    if (value == -9223372036854775808) {
      _friendMessageSince = 0;
    } else {
      _friendMessageSince = value;
    }
  }
  final int _friendMessageUntil;
  {
    final value = IsarCore.readLong(reader, 17);
    if (value == -9223372036854775808) {
      _friendMessageUntil = 0;
    } else {
      _friendMessageUntil = value;
    }
  }
  final int _channelMessageSince;
  {
    final value = IsarCore.readLong(reader, 18);
    if (value == -9223372036854775808) {
      _channelMessageSince = 0;
    } else {
      _channelMessageSince = value;
    }
  }
  final int _channelMessageUntil;
  {
    final value = IsarCore.readLong(reader, 19);
    if (value == -9223372036854775808) {
      _channelMessageUntil = 0;
    } else {
      _channelMessageUntil = value;
    }
  }
  final int _commonMessagesSince;
  {
    final value = IsarCore.readLong(reader, 20);
    if (value == -9223372036854775808) {
      _commonMessagesSince = 0;
    } else {
      _commonMessagesSince = value;
    }
  }
  final int _commonMessagesUntil;
  {
    final value = IsarCore.readLong(reader, 21);
    if (value == -9223372036854775808) {
      _commonMessagesUntil = 0;
    } else {
      _commonMessagesUntil = value;
    }
  }
  final int _groupMessageSince;
  {
    final value = IsarCore.readLong(reader, 22);
    if (value == -9223372036854775808) {
      _groupMessageSince = 0;
    } else {
      _groupMessageSince = value;
    }
  }
  final int _groupMessageUntil;
  {
    final value = IsarCore.readLong(reader, 23);
    if (value == -9223372036854775808) {
      _groupMessageUntil = 0;
    } else {
      _groupMessageUntil = value;
    }
  }
  final int _mlsGroupMessageSince;
  {
    final value = IsarCore.readLong(reader, 24);
    if (value == -9223372036854775808) {
      _mlsGroupMessageSince = 0;
    } else {
      _mlsGroupMessageSince = value;
    }
  }
  final int _mlsGroupMessageUntil;
  {
    final value = IsarCore.readLong(reader, 25);
    if (value == -9223372036854775808) {
      _mlsGroupMessageUntil = 0;
    } else {
      _mlsGroupMessageUntil = value;
    }
  }
  final int _momentSince;
  {
    final value = IsarCore.readLong(reader, 26);
    if (value == -9223372036854775808) {
      _momentSince = 0;
    } else {
      _momentSince = value;
    }
  }
  final int _momentUntil;
  {
    final value = IsarCore.readLong(reader, 27);
    if (value == -9223372036854775808) {
      _momentUntil = 0;
    } else {
      _momentUntil = value;
    }
  }
  final int _zapRecordSince;
  {
    final value = IsarCore.readLong(reader, 28);
    if (value == -9223372036854775808) {
      _zapRecordSince = 0;
    } else {
      _zapRecordSince = value;
    }
  }
  final int _zapRecordUntil;
  {
    final value = IsarCore.readLong(reader, 29);
    if (value == -9223372036854775808) {
      _zapRecordUntil = 0;
    } else {
      _zapRecordUntil = value;
    }
  }
  final object = RelayDBISAR(
    url: _url,
    pubkey: _pubkey,
    description: _description,
    contact: _contact,
    supportedNips: _supportedNips,
    supportedNipExtensions: _supportedNipExtensions,
    software: _software,
    version: _version,
    limitation: _limitation,
    paymentsUrl: _paymentsUrl,
    fees: _fees,
    icon: _icon,
    friendRequestSince: _friendRequestSince,
    friendRequestUntil: _friendRequestUntil,
    friendMessageSince: _friendMessageSince,
    friendMessageUntil: _friendMessageUntil,
    channelMessageSince: _channelMessageSince,
    channelMessageUntil: _channelMessageUntil,
    commonMessagesSince: _commonMessagesSince,
    commonMessagesUntil: _commonMessagesUntil,
    groupMessageSince: _groupMessageSince,
    groupMessageUntil: _groupMessageUntil,
    mlsGroupMessageSince: _mlsGroupMessageSince,
    mlsGroupMessageUntil: _mlsGroupMessageUntil,
    momentSince: _momentSince,
    momentUntil: _momentUntil,
    zapRecordSince: _zapRecordSince,
    zapRecordUntil: _zapRecordUntil,
  );
  object.id = IsarCore.readId(reader);
  object.name = IsarCore.readString(reader, 2);
  return object;
}

@isarProtected
dynamic deserializeRelayDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2);
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
      {
        final value = IsarCore.readLong(reader, 14);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 15:
      {
        final value = IsarCore.readLong(reader, 15);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 16:
      {
        final value = IsarCore.readLong(reader, 16);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 17:
      {
        final value = IsarCore.readLong(reader, 17);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 18:
      {
        final value = IsarCore.readLong(reader, 18);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 19:
      {
        final value = IsarCore.readLong(reader, 19);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 20:
      {
        final value = IsarCore.readLong(reader, 20);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 21:
      {
        final value = IsarCore.readLong(reader, 21);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 22:
      {
        final value = IsarCore.readLong(reader, 22);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 23:
      {
        final value = IsarCore.readLong(reader, 23);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 24:
      {
        final value = IsarCore.readLong(reader, 24);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 25:
      {
        final value = IsarCore.readLong(reader, 25);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 26:
      {
        final value = IsarCore.readLong(reader, 26);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 27:
      {
        final value = IsarCore.readLong(reader, 27);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 28:
      {
        final value = IsarCore.readLong(reader, 28);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 29:
      {
        final value = IsarCore.readLong(reader, 29);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _RelayDBISARUpdate {
  bool call({
    required int id,
    String? url,
    String? name,
    String? pubkey,
    String? description,
    String? contact,
    String? supportedNips,
    String? supportedNipExtensions,
    String? software,
    String? version,
    String? limitation,
    String? paymentsUrl,
    String? fees,
    String? icon,
    int? friendRequestSince,
    int? friendRequestUntil,
    int? friendMessageSince,
    int? friendMessageUntil,
    int? channelMessageSince,
    int? channelMessageUntil,
    int? commonMessagesSince,
    int? commonMessagesUntil,
    int? groupMessageSince,
    int? groupMessageUntil,
    int? mlsGroupMessageSince,
    int? mlsGroupMessageUntil,
    int? momentSince,
    int? momentUntil,
    int? zapRecordSince,
    int? zapRecordUntil,
  });
}

class _RelayDBISARUpdateImpl implements _RelayDBISARUpdate {
  const _RelayDBISARUpdateImpl(this.collection);

  final IsarCollection<int, RelayDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? url = ignore,
    Object? name = ignore,
    Object? pubkey = ignore,
    Object? description = ignore,
    Object? contact = ignore,
    Object? supportedNips = ignore,
    Object? supportedNipExtensions = ignore,
    Object? software = ignore,
    Object? version = ignore,
    Object? limitation = ignore,
    Object? paymentsUrl = ignore,
    Object? fees = ignore,
    Object? icon = ignore,
    Object? friendRequestSince = ignore,
    Object? friendRequestUntil = ignore,
    Object? friendMessageSince = ignore,
    Object? friendMessageUntil = ignore,
    Object? channelMessageSince = ignore,
    Object? channelMessageUntil = ignore,
    Object? commonMessagesSince = ignore,
    Object? commonMessagesUntil = ignore,
    Object? groupMessageSince = ignore,
    Object? groupMessageUntil = ignore,
    Object? mlsGroupMessageSince = ignore,
    Object? mlsGroupMessageUntil = ignore,
    Object? momentSince = ignore,
    Object? momentUntil = ignore,
    Object? zapRecordSince = ignore,
    Object? zapRecordUntil = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (url != ignore) 1: url as String?,
          if (name != ignore) 2: name as String?,
          if (pubkey != ignore) 3: pubkey as String?,
          if (description != ignore) 4: description as String?,
          if (contact != ignore) 5: contact as String?,
          if (supportedNips != ignore) 6: supportedNips as String?,
          if (supportedNipExtensions != ignore)
            7: supportedNipExtensions as String?,
          if (software != ignore) 8: software as String?,
          if (version != ignore) 9: version as String?,
          if (limitation != ignore) 10: limitation as String?,
          if (paymentsUrl != ignore) 11: paymentsUrl as String?,
          if (fees != ignore) 12: fees as String?,
          if (icon != ignore) 13: icon as String?,
          if (friendRequestSince != ignore) 14: friendRequestSince as int?,
          if (friendRequestUntil != ignore) 15: friendRequestUntil as int?,
          if (friendMessageSince != ignore) 16: friendMessageSince as int?,
          if (friendMessageUntil != ignore) 17: friendMessageUntil as int?,
          if (channelMessageSince != ignore) 18: channelMessageSince as int?,
          if (channelMessageUntil != ignore) 19: channelMessageUntil as int?,
          if (commonMessagesSince != ignore) 20: commonMessagesSince as int?,
          if (commonMessagesUntil != ignore) 21: commonMessagesUntil as int?,
          if (groupMessageSince != ignore) 22: groupMessageSince as int?,
          if (groupMessageUntil != ignore) 23: groupMessageUntil as int?,
          if (mlsGroupMessageSince != ignore) 24: mlsGroupMessageSince as int?,
          if (mlsGroupMessageUntil != ignore) 25: mlsGroupMessageUntil as int?,
          if (momentSince != ignore) 26: momentSince as int?,
          if (momentUntil != ignore) 27: momentUntil as int?,
          if (zapRecordSince != ignore) 28: zapRecordSince as int?,
          if (zapRecordUntil != ignore) 29: zapRecordUntil as int?,
        }) >
        0;
  }
}

sealed class _RelayDBISARUpdateAll {
  int call({
    required List<int> id,
    String? url,
    String? name,
    String? pubkey,
    String? description,
    String? contact,
    String? supportedNips,
    String? supportedNipExtensions,
    String? software,
    String? version,
    String? limitation,
    String? paymentsUrl,
    String? fees,
    String? icon,
    int? friendRequestSince,
    int? friendRequestUntil,
    int? friendMessageSince,
    int? friendMessageUntil,
    int? channelMessageSince,
    int? channelMessageUntil,
    int? commonMessagesSince,
    int? commonMessagesUntil,
    int? groupMessageSince,
    int? groupMessageUntil,
    int? mlsGroupMessageSince,
    int? mlsGroupMessageUntil,
    int? momentSince,
    int? momentUntil,
    int? zapRecordSince,
    int? zapRecordUntil,
  });
}

class _RelayDBISARUpdateAllImpl implements _RelayDBISARUpdateAll {
  const _RelayDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, RelayDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? url = ignore,
    Object? name = ignore,
    Object? pubkey = ignore,
    Object? description = ignore,
    Object? contact = ignore,
    Object? supportedNips = ignore,
    Object? supportedNipExtensions = ignore,
    Object? software = ignore,
    Object? version = ignore,
    Object? limitation = ignore,
    Object? paymentsUrl = ignore,
    Object? fees = ignore,
    Object? icon = ignore,
    Object? friendRequestSince = ignore,
    Object? friendRequestUntil = ignore,
    Object? friendMessageSince = ignore,
    Object? friendMessageUntil = ignore,
    Object? channelMessageSince = ignore,
    Object? channelMessageUntil = ignore,
    Object? commonMessagesSince = ignore,
    Object? commonMessagesUntil = ignore,
    Object? groupMessageSince = ignore,
    Object? groupMessageUntil = ignore,
    Object? mlsGroupMessageSince = ignore,
    Object? mlsGroupMessageUntil = ignore,
    Object? momentSince = ignore,
    Object? momentUntil = ignore,
    Object? zapRecordSince = ignore,
    Object? zapRecordUntil = ignore,
  }) {
    return collection.updateProperties(id, {
      if (url != ignore) 1: url as String?,
      if (name != ignore) 2: name as String?,
      if (pubkey != ignore) 3: pubkey as String?,
      if (description != ignore) 4: description as String?,
      if (contact != ignore) 5: contact as String?,
      if (supportedNips != ignore) 6: supportedNips as String?,
      if (supportedNipExtensions != ignore)
        7: supportedNipExtensions as String?,
      if (software != ignore) 8: software as String?,
      if (version != ignore) 9: version as String?,
      if (limitation != ignore) 10: limitation as String?,
      if (paymentsUrl != ignore) 11: paymentsUrl as String?,
      if (fees != ignore) 12: fees as String?,
      if (icon != ignore) 13: icon as String?,
      if (friendRequestSince != ignore) 14: friendRequestSince as int?,
      if (friendRequestUntil != ignore) 15: friendRequestUntil as int?,
      if (friendMessageSince != ignore) 16: friendMessageSince as int?,
      if (friendMessageUntil != ignore) 17: friendMessageUntil as int?,
      if (channelMessageSince != ignore) 18: channelMessageSince as int?,
      if (channelMessageUntil != ignore) 19: channelMessageUntil as int?,
      if (commonMessagesSince != ignore) 20: commonMessagesSince as int?,
      if (commonMessagesUntil != ignore) 21: commonMessagesUntil as int?,
      if (groupMessageSince != ignore) 22: groupMessageSince as int?,
      if (groupMessageUntil != ignore) 23: groupMessageUntil as int?,
      if (mlsGroupMessageSince != ignore) 24: mlsGroupMessageSince as int?,
      if (mlsGroupMessageUntil != ignore) 25: mlsGroupMessageUntil as int?,
      if (momentSince != ignore) 26: momentSince as int?,
      if (momentUntil != ignore) 27: momentUntil as int?,
      if (zapRecordSince != ignore) 28: zapRecordSince as int?,
      if (zapRecordUntil != ignore) 29: zapRecordUntil as int?,
    });
  }
}

extension RelayDBISARUpdate on IsarCollection<int, RelayDBISAR> {
  _RelayDBISARUpdate get update => _RelayDBISARUpdateImpl(this);

  _RelayDBISARUpdateAll get updateAll => _RelayDBISARUpdateAllImpl(this);
}

sealed class _RelayDBISARQueryUpdate {
  int call({
    String? url,
    String? name,
    String? pubkey,
    String? description,
    String? contact,
    String? supportedNips,
    String? supportedNipExtensions,
    String? software,
    String? version,
    String? limitation,
    String? paymentsUrl,
    String? fees,
    String? icon,
    int? friendRequestSince,
    int? friendRequestUntil,
    int? friendMessageSince,
    int? friendMessageUntil,
    int? channelMessageSince,
    int? channelMessageUntil,
    int? commonMessagesSince,
    int? commonMessagesUntil,
    int? groupMessageSince,
    int? groupMessageUntil,
    int? mlsGroupMessageSince,
    int? mlsGroupMessageUntil,
    int? momentSince,
    int? momentUntil,
    int? zapRecordSince,
    int? zapRecordUntil,
  });
}

class _RelayDBISARQueryUpdateImpl implements _RelayDBISARQueryUpdate {
  const _RelayDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<RelayDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? url = ignore,
    Object? name = ignore,
    Object? pubkey = ignore,
    Object? description = ignore,
    Object? contact = ignore,
    Object? supportedNips = ignore,
    Object? supportedNipExtensions = ignore,
    Object? software = ignore,
    Object? version = ignore,
    Object? limitation = ignore,
    Object? paymentsUrl = ignore,
    Object? fees = ignore,
    Object? icon = ignore,
    Object? friendRequestSince = ignore,
    Object? friendRequestUntil = ignore,
    Object? friendMessageSince = ignore,
    Object? friendMessageUntil = ignore,
    Object? channelMessageSince = ignore,
    Object? channelMessageUntil = ignore,
    Object? commonMessagesSince = ignore,
    Object? commonMessagesUntil = ignore,
    Object? groupMessageSince = ignore,
    Object? groupMessageUntil = ignore,
    Object? mlsGroupMessageSince = ignore,
    Object? mlsGroupMessageUntil = ignore,
    Object? momentSince = ignore,
    Object? momentUntil = ignore,
    Object? zapRecordSince = ignore,
    Object? zapRecordUntil = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (url != ignore) 1: url as String?,
      if (name != ignore) 2: name as String?,
      if (pubkey != ignore) 3: pubkey as String?,
      if (description != ignore) 4: description as String?,
      if (contact != ignore) 5: contact as String?,
      if (supportedNips != ignore) 6: supportedNips as String?,
      if (supportedNipExtensions != ignore)
        7: supportedNipExtensions as String?,
      if (software != ignore) 8: software as String?,
      if (version != ignore) 9: version as String?,
      if (limitation != ignore) 10: limitation as String?,
      if (paymentsUrl != ignore) 11: paymentsUrl as String?,
      if (fees != ignore) 12: fees as String?,
      if (icon != ignore) 13: icon as String?,
      if (friendRequestSince != ignore) 14: friendRequestSince as int?,
      if (friendRequestUntil != ignore) 15: friendRequestUntil as int?,
      if (friendMessageSince != ignore) 16: friendMessageSince as int?,
      if (friendMessageUntil != ignore) 17: friendMessageUntil as int?,
      if (channelMessageSince != ignore) 18: channelMessageSince as int?,
      if (channelMessageUntil != ignore) 19: channelMessageUntil as int?,
      if (commonMessagesSince != ignore) 20: commonMessagesSince as int?,
      if (commonMessagesUntil != ignore) 21: commonMessagesUntil as int?,
      if (groupMessageSince != ignore) 22: groupMessageSince as int?,
      if (groupMessageUntil != ignore) 23: groupMessageUntil as int?,
      if (mlsGroupMessageSince != ignore) 24: mlsGroupMessageSince as int?,
      if (mlsGroupMessageUntil != ignore) 25: mlsGroupMessageUntil as int?,
      if (momentSince != ignore) 26: momentSince as int?,
      if (momentUntil != ignore) 27: momentUntil as int?,
      if (zapRecordSince != ignore) 28: zapRecordSince as int?,
      if (zapRecordUntil != ignore) 29: zapRecordUntil as int?,
    });
  }
}

extension RelayDBISARQueryUpdate on IsarQuery<RelayDBISAR> {
  _RelayDBISARQueryUpdate get updateFirst =>
      _RelayDBISARQueryUpdateImpl(this, limit: 1);

  _RelayDBISARQueryUpdate get updateAll => _RelayDBISARQueryUpdateImpl(this);
}

class _RelayDBISARQueryBuilderUpdateImpl implements _RelayDBISARQueryUpdate {
  const _RelayDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<RelayDBISAR, RelayDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? url = ignore,
    Object? name = ignore,
    Object? pubkey = ignore,
    Object? description = ignore,
    Object? contact = ignore,
    Object? supportedNips = ignore,
    Object? supportedNipExtensions = ignore,
    Object? software = ignore,
    Object? version = ignore,
    Object? limitation = ignore,
    Object? paymentsUrl = ignore,
    Object? fees = ignore,
    Object? icon = ignore,
    Object? friendRequestSince = ignore,
    Object? friendRequestUntil = ignore,
    Object? friendMessageSince = ignore,
    Object? friendMessageUntil = ignore,
    Object? channelMessageSince = ignore,
    Object? channelMessageUntil = ignore,
    Object? commonMessagesSince = ignore,
    Object? commonMessagesUntil = ignore,
    Object? groupMessageSince = ignore,
    Object? groupMessageUntil = ignore,
    Object? mlsGroupMessageSince = ignore,
    Object? mlsGroupMessageUntil = ignore,
    Object? momentSince = ignore,
    Object? momentUntil = ignore,
    Object? zapRecordSince = ignore,
    Object? zapRecordUntil = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (url != ignore) 1: url as String?,
        if (name != ignore) 2: name as String?,
        if (pubkey != ignore) 3: pubkey as String?,
        if (description != ignore) 4: description as String?,
        if (contact != ignore) 5: contact as String?,
        if (supportedNips != ignore) 6: supportedNips as String?,
        if (supportedNipExtensions != ignore)
          7: supportedNipExtensions as String?,
        if (software != ignore) 8: software as String?,
        if (version != ignore) 9: version as String?,
        if (limitation != ignore) 10: limitation as String?,
        if (paymentsUrl != ignore) 11: paymentsUrl as String?,
        if (fees != ignore) 12: fees as String?,
        if (icon != ignore) 13: icon as String?,
        if (friendRequestSince != ignore) 14: friendRequestSince as int?,
        if (friendRequestUntil != ignore) 15: friendRequestUntil as int?,
        if (friendMessageSince != ignore) 16: friendMessageSince as int?,
        if (friendMessageUntil != ignore) 17: friendMessageUntil as int?,
        if (channelMessageSince != ignore) 18: channelMessageSince as int?,
        if (channelMessageUntil != ignore) 19: channelMessageUntil as int?,
        if (commonMessagesSince != ignore) 20: commonMessagesSince as int?,
        if (commonMessagesUntil != ignore) 21: commonMessagesUntil as int?,
        if (groupMessageSince != ignore) 22: groupMessageSince as int?,
        if (groupMessageUntil != ignore) 23: groupMessageUntil as int?,
        if (mlsGroupMessageSince != ignore) 24: mlsGroupMessageSince as int?,
        if (mlsGroupMessageUntil != ignore) 25: mlsGroupMessageUntil as int?,
        if (momentSince != ignore) 26: momentSince as int?,
        if (momentUntil != ignore) 27: momentUntil as int?,
        if (zapRecordSince != ignore) 28: zapRecordSince as int?,
        if (zapRecordUntil != ignore) 29: zapRecordUntil as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension RelayDBISARQueryBuilderUpdate
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QOperations> {
  _RelayDBISARQueryUpdate get updateFirst =>
      _RelayDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _RelayDBISARQueryUpdate get updateAll =>
      _RelayDBISARQueryBuilderUpdateImpl(this);
}

extension RelayDBISARQueryFilter
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QFilterCondition> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      urlGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      urlLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlContains(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyContains(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactContains(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsContains(String value,
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsMatches(String pattern,
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> softwareEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> softwareBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> softwareMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionContains(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      feesIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      feesGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      feesLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesContains(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      feesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      iconIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconGreaterThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      iconGreaterThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconLessThan(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      iconLessThanOrEqualTo(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconBetween(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconStartsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconEndsWith(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconContains(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconMatches(
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

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      iconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 15,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 16,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 16,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 16,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 16,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 16,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 16,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 17,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 18,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 19,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 19,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 19,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 19,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 19,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 19,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 20,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 21,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 21,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 21,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 21,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 21,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 21,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 22,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 22,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 22,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 22,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 22,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 22,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 23,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 24,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      mlsGroupMessageUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 25,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 26,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 27,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 28,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 29,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension RelayDBISARQueryObject
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QFilterCondition> {}

extension RelayDBISARQuerySortBy
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QSortBy> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByUrlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByContact(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByContactDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySupportedNips(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySupportedNipsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortBySupportedNipExtensions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortBySupportedNipExtensionsDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySoftware(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySoftwareDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByVersionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByLimitation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByLimitationDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPaymentsUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPaymentsUrlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByFees(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByFeesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByIconDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMlsGroupMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMlsGroupMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMlsGroupMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMlsGroupMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByMomentSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByMomentSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByMomentUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByMomentUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByZapRecordSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByZapRecordSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByZapRecordUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByZapRecordUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29, sort: Sort.desc);
    });
  }
}

extension RelayDBISARQuerySortThenBy
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QSortThenBy> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByUrlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByContact(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByContactDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySupportedNips(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySupportedNipsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenBySupportedNipExtensions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenBySupportedNipExtensionsDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySoftware(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySoftwareDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByVersionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByLimitation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByLimitationDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPaymentsUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPaymentsUrlDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByFees(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByFeesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByIconDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMlsGroupMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMlsGroupMessageSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMlsGroupMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMlsGroupMessageUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByMomentSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByMomentSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByMomentUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByMomentUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByZapRecordSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByZapRecordSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByZapRecordUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByZapRecordUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29, sort: Sort.desc);
    });
  }
}

extension RelayDBISARQueryWhereDistinct
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByContact(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctBySupportedNips({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctBySupportedNipExtensions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctBySoftware(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByLimitation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByPaymentsUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByFees(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct> distinctByIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByFriendRequestSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByFriendRequestUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByFriendMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByFriendMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByChannelMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(18);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByChannelMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(19);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByCommonMessagesSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(20);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByCommonMessagesUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(21);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByGroupMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(22);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByGroupMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(23);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByMlsGroupMessageSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(24);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByMlsGroupMessageUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(25);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByMomentSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(26);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByMomentUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(27);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByZapRecordSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(28);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterDistinct>
      distinctByZapRecordUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(29);
    });
  }
}

extension RelayDBISARQueryProperty1
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QProperty> {
  QueryBuilder<RelayDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RelayDBISAR, String, QAfterProperty> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> contactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> supportedNipsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty>
      supportedNipExtensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> softwareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> limitationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> paymentsUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> feesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<RelayDBISAR, String?, QAfterProperty> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> friendRequestSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> friendRequestUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> friendMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> friendMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> channelMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> channelMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> commonMessagesSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> commonMessagesUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> groupMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> groupMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty>
      mlsGroupMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty>
      mlsGroupMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> momentSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> momentUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> zapRecordSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<RelayDBISAR, int, QAfterProperty> zapRecordUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }
}

extension RelayDBISARQueryProperty2<R>
    on QueryBuilder<RelayDBISAR, R, QAfterProperty> {
  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String), QAfterProperty> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> contactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty>
      supportedNipsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty>
      supportedNipExtensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> softwareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> limitationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty>
      paymentsUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> feesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<RelayDBISAR, (R, String?), QAfterProperty> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      friendRequestSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      friendRequestUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      friendMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      friendMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      channelMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      channelMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      commonMessagesSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      commonMessagesUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      groupMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      groupMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      mlsGroupMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty>
      mlsGroupMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty> momentSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty> momentUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty> zapRecordSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<RelayDBISAR, (R, int), QAfterProperty> zapRecordUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }
}

extension RelayDBISARQueryProperty3<R1, R2>
    on QueryBuilder<RelayDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String), QOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> contactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations>
      supportedNipsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations>
      supportedNipExtensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> softwareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations>
      limitationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations>
      paymentsUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> feesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, String?), QOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      friendRequestSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      friendRequestUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      friendMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      friendMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      channelMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      channelMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      commonMessagesSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      commonMessagesUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      groupMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      groupMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      mlsGroupMessageSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      mlsGroupMessageUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations> momentSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations> momentUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      zapRecordSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<RelayDBISAR, (R1, R2, int), QOperations>
      zapRecordUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }
}
