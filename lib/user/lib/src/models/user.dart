// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:characters/characters.dart';
import 'package:cloud_firestore_helper/cloud_firestore_helper.dart';
import 'package:helper_functions/helper_functions.dart';
import 'package:user/src/models/sharezone_plus_status.dart';

import 'features.dart';
import 'state_enum.dart';
import 'tips/user_tip_data.dart';
import 'type_of_user.dart';
import 'user_settings.dart';

class AppUser {
  final String id;
  final String name;
  final String abbreviation;

  final TypeOfUser typeOfUser;

  final String? referralLink, referredBy;
  final int referralScore;

  final StateEnum state;
  final String? reminderTime;
  final List<String?> notificationTokens;
  final bool? blackboardNotifications;
  final bool? commentsNotifications;
  final UserSettings userSettings;
  final UserTipData userTipData;
  final DateTime? createdOn;
  final Features? features;
  final SharezonePlusStatus? sharezonePlus;

  final Map<String, dynamic> legalData;

  AppUser._({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.typeOfUser,
    required this.referralLink,
    required this.referredBy,
    required this.referralScore,
    required this.reminderTime,
    required this.notificationTokens,
    required this.state,
    required this.blackboardNotifications,
    required this.commentsNotifications,
    required this.userSettings,
    required this.userTipData,
    required this.createdOn,
    this.features,
    required this.sharezonePlus,
    required this.legalData,
  });

  factory AppUser.create({required String id}) {
    return AppUser._(
      id: id,
      name: "Anonymer Account",
      abbreviation: "AA",
      typeOfUser: TypeOfUser.student,
      notificationTokens: [],
      reminderTime: "18:00",
      referralLink: null,
      referredBy: null,
      referralScore: 0,
      state: StateEnum.anonymous,
      blackboardNotifications: true,
      commentsNotifications: true,
      userSettings: UserSettings.defaultSettings(),
      userTipData: UserTipData.empty(),
      createdOn: null,
      sharezonePlus: null,
      legalData: {},
    );
  }

  factory AppUser.fromData(Map<String, dynamic>? data, {required String id}) {
    if (data == null) {
      return AppUser._(
        id: id,
        name: "Anonymer Account",
        abbreviation: "AA",
        typeOfUser: TypeOfUser.student,
        notificationTokens: [],
        reminderTime: null,
        referralLink: null,
        referralScore: 0,
        referredBy: null,
        state: StateEnum.anonymous,
        blackboardNotifications: true,
        commentsNotifications: true,
        userSettings: UserSettings.defaultSettings(),
        userTipData: UserTipData.empty(),
        createdOn: null,
        sharezonePlus: null,
        legalData: {},
      );
    }
    return AppUser._(
      id: id,
      name: data['name'] ?? '',
      abbreviation: generateAbbreviation(data['name']),
      typeOfUser: TypeOfUser.values.tryByName(
        data['typeOfUser'],
        defaultValue: TypeOfUser.unknown,
      ),
      notificationTokens: decodeList(data['notificationTokens'], (it) => it),
      reminderTime: data['reminderTime'],
      referralLink: data['referralLink'],
      referredBy: data['referredBy'],
      referralScore: data['referralScore'] ?? 0,
      state: StateEnum.values[data['state'] ?? 18],
      blackboardNotifications: data['blackboardNotifications'],
      commentsNotifications: data['commentsNotifications'],
      userSettings: UserSettings.fromData(data['settings']),
      userTipData: UserTipData.fromData(data['tips']),
      createdOn: dateTimeFromTimestampOrNull(data['createdOn']),
      features: Features.fromJson(data['features']),
      sharezonePlus: SharezonePlusStatus.fromData(data['sharezonePlus']),
      legalData: decodeMap(
        data['legal'] ?? {},
        (key, decodedMapValue) => decodedMapValue as Map,
      ),
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      'abbreviation': abbreviation,
      'typeOfUser': typeOfUser.name,
      'notificationTokens': notificationTokens,
      'reminderTime': reminderTime,
      'state': state.index,
      'referralScore': referralScore,
      'points': 0,
      'blackboardNotifications': blackboardNotifications,
      'commentsNotifications': commentsNotifications,
      'settings': userSettings.toJson(),
      'tips': userTipData.toJson(),
      'features': features?.toJson(),
      'legal': legalData,
    };
  }

  Map<String, dynamic> toEditJson() {
    return {
      'name': name,
      'abbreviation': abbreviation,
      'typeOfUser': typeOfUser.name,
      'reminderTime': reminderTime,
      'state': state.index,
      'referralScore': referralScore,
      'points': 0,
      'blackboardNotifications': blackboardNotifications,
      'commentsNotifications': commentsNotifications,
      'settings': userSettings.toJson(),
      'tips': userTipData.toJson(),
      'features': features?.toJson(),
    };
  }

  AppUser copyWith({
    String? id,
    String? name,
    String? abbreviation,
    TypeOfUser? typeOfUser,
    String? reminderTime,
    int? referralScore,
    List<String>? notificationTokens,
    StateEnum? state,
    bool? blackboardNotifications,
    bool? commentsNotifications,
    UserSettings? userSettings,
    UserTipData? userTipData,
    SharezonePlusStatus? sharezonePlus,
    Features? features,
    Map<String, dynamic>? legalData,
  }) {
    return AppUser._(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
      typeOfUser: typeOfUser ?? this.typeOfUser,
      notificationTokens: notificationTokens ?? this.notificationTokens,
      reminderTime: reminderTime ?? this.reminderTime,
      referralLink: referralLink,
      referralScore: referralScore ?? this.referralScore,
      state: state ?? this.state,
      blackboardNotifications:
          blackboardNotifications ?? this.blackboardNotifications,
      commentsNotifications:
          commentsNotifications ?? this.commentsNotifications,
      userSettings: userSettings ?? this.userSettings,
      userTipData: userTipData ?? this.userTipData,
      createdOn: createdOn,
      referredBy: referredBy,
      features: features ?? this.features,
      sharezonePlus: sharezonePlus ?? this.sharezonePlus,
      legalData: legalData ?? this.legalData,
    );
  }
}

String generateAbbreviation(String? name) {
  if (name != null) {
    if (name.length <= 1) {
      return name.toUpperCase();
    }
    return name.characters.first;
  }
  return "";
}

// String generateAbbreviation(String name) {
//   if (name != null) {
//     if (name.length <= 1) {
//       return name.toUpperCase();
//     }
//     final splittedName = name.split(" ");
//     if (splittedName.length == 1) {
//       return splittedName[0].substring(0, 2).toUpperCase();
//     }
//     final abbreviation =
//         '${splittedName[0].substring(0, 1)}${splittedName[splittedName.length - 1].substring(0, 1)}'.toUpperCase();
//     return abbreviation;
//   }
//   return "";
// }
