// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:chatcore/src/account/model/userDB.dart' as prefix1;
import 'package:chatcore/src/common/database/db.dart' as prefix0;
import 'package:chatcore/src/common/database/db_object.dart' as prefix2;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Reflector(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'UserDB',
            r'.UserDB',
            134217735,
            0,
            const prefix0.Reflector(),
            const <int>[
              0,
              1,
              2,
              3,
              4,
              5,
              6,
              7,
              8,
              9,
              10,
              11,
              12,
              13,
              14,
              15,
              16,
              17,
              18,
              19,
              20,
              47
            ],
            const <int>[
              48,
              49,
              50,
              51,
              52,
              13,
              19,
              20,
              21,
              22,
              23,
              24,
              25,
              26,
              27,
              28,
              29,
              30,
              31,
              32,
              33,
              34,
              35,
              36,
              37,
              38,
              39,
              40,
              41,
              42,
              43,
              44,
              45,
              46
            ],
            const <int>[14, 15, 16, 17, 18],
            1,
            {
              r'fromMap': () => prefix1.UserDB.fromMap,
              r'tableName': () => prefix1.UserDB.tableName,
              r'primaryKey': () => prefix1.UserDB.primaryKey,
              r'decodePubkey': () => prefix1.UserDB.decodePubkey,
              r'decodePrivkey': () => prefix1.UserDB.decodePrivkey
            },
            {},
            {
              r'': (bool b) => (
                      {pubKey = '',
                      encryptedPrivKey = '',
                      privkey = '',
                      defaultPassword = '',
                      name = '',
                      mainRelay = '',
                      dns = '',
                      lnurl = '',
                      badges = '',
                      gender = '',
                      area = '',
                      about = '',
                      picture = ''}) =>
                  b
                      ? prefix1.UserDB(
                          about: about,
                          area: area,
                          badges: badges,
                          defaultPassword: defaultPassword,
                          dns: dns,
                          encryptedPrivKey: encryptedPrivKey,
                          gender: gender,
                          lnurl: lnurl,
                          mainRelay: mainRelay,
                          name: name,
                          picture: picture,
                          privkey: privkey,
                          pubKey: pubKey)
                      : null
            },
            0,
            0,
            const <int>[],
            const <Object>[prefix0.reflector],
            null),
        r.NonGenericClassMirrorImpl(
            r'DBObject',
            r'.DBObject',
            134218247,
            1,
            const prefix0.Reflector(),
            const <int>[53, 54, 55, 56, 57, 58, 59, 60, 61],
            const <int>[48, 49, 50, 51, 52],
            const <int>[54, 55, 56, 57, 58, 59, 60],
            -1,
            {
              r'fromMap': () => prefix2.DBObject.fromMap,
              r'updateTable': () => prefix2.DBObject.updateTable,
              r'tableName': () => prefix2.DBObject.tableName,
              r'primaryKey': () => prefix2.DBObject.primaryKey,
              r'ignoreKey': () => prefix2.DBObject.ignoreKey,
              r'columnExtras': () => prefix2.DBObject.columnExtras,
              r'isBlobColumn': () => prefix2.DBObject.isBlobColumn
            },
            {},
            {},
            1,
            1,
            const <int>[],
            const <Object>[prefix0.reflector],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'pubKey', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'encryptedPrivKey', 67239941, 0,
            const prefix0.Reflector(), -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'privkey', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'defaultPassword', 67239941, 0,
            const prefix0.Reflector(), -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'name', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'mainRelay', 67239941, 0,
            const prefix0.Reflector(), -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'dns', 67239941, 0, const prefix0.Reflector(), -1,
            2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'lnurl', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'badges', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'gender', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'area', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'about', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.VariableMirrorImpl(r'picture', 67239941, 0, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const []),
        r.MethodMirrorImpl(r'toMap', 35651586, 0, -1, 5, 6, const <int>[3, 4],
            const <int>[], const prefix0.Reflector(), const <Object>[override]),
        r.MethodMirrorImpl(r'fromMap', 2097170, 0, 0, 0, 0, const <int>[],
            const <int>[0], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'tableName', 2097170, 0, -1, 2, 2, const <int>[],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'primaryKey', 35651602, 0, -1, 7, 8, const <int>[2],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'decodePubkey', 524306, 0, -1, -1, -1,
            const <int>[], const <int>[1], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'decodePrivkey', 524306, 0, -1, -1, -1,
            const <int>[], const <int>[2], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'encodedPubkey', 2097154, 0, -1, 3, 3,
            const <int>[], const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'encodedPrivkey', 2097154, 0, -1, 3, 3,
            const <int>[], const <int>[], const prefix0.Reflector(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 0, 21),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 0, 22),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 1, 23),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 1, 24),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 2, 25),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 2, 26),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 3, 27),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 3, 28),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 4, 29),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 4, 30),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 5, 31),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 5, 32),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 6, 33),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 6, 34),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 7, 35),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 7, 36),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 8, 37),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 8, 38),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 9, 39),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 9, 40),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 10, 41),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 10, 42),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 11, 43),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 11, 44),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 12, 45),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 12, 46),
        r.MethodMirrorImpl(
            r'',
            0,
            0,
            -1,
            0,
            0,
            const <int>[],
            const <int>[3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
            const prefix0.Reflector(),
            const []),
        r.MethodMirrorImpl(r'==', 2097154, -1, -1, 9, 9, const <int>[],
            const <int>[29], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'toString', 2097154, -1, -1, 3, 3, const <int>[],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            524290,
            -1,
            -1,
            -1,
            -1,
            const <int>[],
            const <int>[30],
            const prefix0.Reflector(),
            const []),
        r.MethodMirrorImpl(r'hashCode', 2097155, -1, -1, 10, 10, const <int>[],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'runtimeType', 2097155, -1, -1, 11, 11,
            const <int>[], const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'toMap', 35652098, 1, -1, 5, 6, const <int>[3, 4],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'fromMap', 2097170, 1, 1, 1, 1, const <int>[],
            const <int>[31], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(
            r'updateTable',
            35651602,
            1,
            -1,
            12,
            13,
            const <int>[3, 2],
            const <int>[],
            const prefix0.Reflector(),
            const []),
        r.MethodMirrorImpl(r'tableName', 2097170, 1, -1, 2, 2, const <int>[],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'primaryKey', 35651602, 1, -1, 7, 8, const <int>[2],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'ignoreKey', 35651602, 1, -1, 7, 8, const <int>[2],
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(
            r'columnExtras',
            35651602,
            1,
            -1,
            14,
            15,
            const <int>[3, 3],
            const <int>[],
            const prefix0.Reflector(),
            const []),
        r.MethodMirrorImpl(r'isBlobColumn', 2097170, 1, -1, 9, 9, const <int>[],
            const <int>[32], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'', 64, 1, -1, 1, 1, const <int>[], const <int>[],
            const prefix0.Reflector(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(r'map', 151126022, 14, const prefix0.Reflector(),
            -1, 5, 6, const <int>[3, 4], const [], null, null),
        r.ParameterMirrorImpl(
            r'pubkey',
            134348806,
            17,
            const prefix0.Reflector(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'privkey',
            134348806,
            18,
            const prefix0.Reflector(),
            -1,
            3,
            3,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'pubKey',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #pubKey),
        r.ParameterMirrorImpl(
            r'encryptedPrivKey',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #encryptedPrivKey),
        r.ParameterMirrorImpl(
            r'privkey',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #privkey),
        r.ParameterMirrorImpl(
            r'defaultPassword',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #defaultPassword),
        r.ParameterMirrorImpl(r'name', 67255302, 47, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], '', #name),
        r.ParameterMirrorImpl(
            r'mainRelay',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #mainRelay),
        r.ParameterMirrorImpl(r'dns', 67255302, 47, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], '', #dns),
        r.ParameterMirrorImpl(r'lnurl', 67255302, 47, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], '', #lnurl),
        r.ParameterMirrorImpl(
            r'badges',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #badges),
        r.ParameterMirrorImpl(
            r'gender',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #gender),
        r.ParameterMirrorImpl(r'area', 67255302, 47, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], '', #area),
        r.ParameterMirrorImpl(r'about', 67255302, 47, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], '', #about),
        r.ParameterMirrorImpl(
            r'picture',
            67255302,
            47,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            '',
            #picture),
        r.ParameterMirrorImpl(
            r'_pubKey',
            67240038,
            22,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_encryptedPrivKey',
            67240038,
            24,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_privkey',
            67240038,
            26,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_defaultPassword',
            67240038,
            28,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'_name', 67240038, 30, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], null, null),
        r.ParameterMirrorImpl(
            r'_mainRelay',
            67240038,
            32,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'_dns', 67240038, 34, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], null, null),
        r.ParameterMirrorImpl(
            r'_lnurl',
            67240038,
            36,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_badges',
            67240038,
            38,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_gender',
            67240038,
            40,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'_area', 67240038, 42, const prefix0.Reflector(),
            -1, 2, 2, const <int>[], const [], null, null),
        r.ParameterMirrorImpl(
            r'_about',
            67240038,
            44,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_picture',
            67240038,
            46,
            const prefix0.Reflector(),
            -1,
            2,
            2,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'other',
            134348806,
            48,
            const prefix0.Reflector(),
            -1,
            16,
            16,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            134348806,
            50,
            const prefix0.Reflector(),
            -1,
            17,
            17,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(r'map', 151126022, 54, const prefix0.Reflector(),
            -1, 5, 6, const <int>[3, 4], const [], null, null),
        r.ParameterMirrorImpl(r'key', 134348806, 60, const prefix0.Reflector(),
            -1, 3, 3, const <int>[], const [], null, null)
      ],
      <Type>[
        prefix1.UserDB,
        prefix2.DBObject,
        String,
        String,
        Object,
        const m.TypeValue<Map<String, Object>>().type,
        Map,
        const m.TypeValue<List<String>>().type,
        List,
        bool,
        int,
        Type,
        const m.TypeValue<Map<String, String>>().type,
        Map,
        const m.TypeValue<Map<String, String>>().type,
        Map,
        Object,
        Invocation
      ],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'toMap': (dynamic instance) => instance.toMap,
        r'encodedPubkey': (dynamic instance) => instance.encodedPubkey,
        r'encodedPrivkey': (dynamic instance) => instance.encodedPrivkey,
        r'pubKey': (dynamic instance) => instance.pubKey,
        r'encryptedPrivKey': (dynamic instance) => instance.encryptedPrivKey,
        r'privkey': (dynamic instance) => instance.privkey,
        r'defaultPassword': (dynamic instance) => instance.defaultPassword,
        r'name': (dynamic instance) => instance.name,
        r'mainRelay': (dynamic instance) => instance.mainRelay,
        r'dns': (dynamic instance) => instance.dns,
        r'lnurl': (dynamic instance) => instance.lnurl,
        r'badges': (dynamic instance) => instance.badges,
        r'gender': (dynamic instance) => instance.gender,
        r'area': (dynamic instance) => instance.area,
        r'about': (dynamic instance) => instance.about,
        r'picture': (dynamic instance) => instance.picture
      },
      {
        r'pubKey=': (dynamic instance, value) => instance.pubKey = value,
        r'encryptedPrivKey=': (dynamic instance, value) =>
            instance.encryptedPrivKey = value,
        r'privkey=': (dynamic instance, value) => instance.privkey = value,
        r'defaultPassword=': (dynamic instance, value) =>
            instance.defaultPassword = value,
        r'name=': (dynamic instance, value) => instance.name = value,
        r'mainRelay=': (dynamic instance, value) => instance.mainRelay = value,
        r'dns=': (dynamic instance, value) => instance.dns = value,
        r'lnurl=': (dynamic instance, value) => instance.lnurl = value,
        r'badges=': (dynamic instance, value) => instance.badges = value,
        r'gender=': (dynamic instance, value) => instance.gender = value,
        r'area=': (dynamic instance, value) => instance.area = value,
        r'about=': (dynamic instance, value) => instance.about = value,
        r'picture=': (dynamic instance, value) => instance.picture = value
      },
      <m.LibraryMirror>[
        r.LibraryMirrorImpl(r'', Uri.parse(r'reflectable://0/'),
            const prefix0.Reflector(), const <int>[], {}, {}, const [], null),
        r.LibraryMirrorImpl(r'', Uri.parse(r'reflectable://1/'),
            const prefix0.Reflector(), const <int>[], {}, {}, const [], null)
      ],
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
