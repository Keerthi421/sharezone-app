// Copyright (c) 2023 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:clock/clock.dart';

typedef ObjectMapBuilder<T> = T Function(String key, dynamic decodedMapValue);
typedef ObjectListBuilder<T> = T Function(dynamic decodedMapValue);

Map<String, T> decodeMap<T>(dynamic data, ObjectMapBuilder<T> builder) {
  Map<dynamic, dynamic>? originaldata = data?.cast<dynamic, dynamic>();
  if (originaldata != null) {
    originaldata.removeWhere((key, value) => value == null);
  }
  Map<String, dynamic> decodedMap = (originaldata ?? {}).map<String, dynamic>(
    (dynamic key, dynamic value) => MapEntry<String, dynamic>(key, value),
  );
  return decodedMap.map((key, value) => MapEntry(key, builder(key, value)));
}

Map<T1, T2> decodeMapAdvanced<T1, T2>(
  dynamic data,
  MapEntry<T1, T2> Function(dynamic key, dynamic value) mapEntryBuilder,
) {
  Map<dynamic, dynamic>? originaldata = data?.cast<dynamic, dynamic>();
  if (originaldata != null) {
    originaldata.removeWhere((key, value) => value == null);
  }
  final decodedMap = (originaldata ?? {}).map(
    (key, value) => mapEntryBuilder(key, value),
  );
  return decodedMap;
}

List<T> decodeList<T>(dynamic data, ObjectListBuilder<T> builder) {
  List<dynamic>? originaldata = data;
  if (originaldata == null) return [];
  return originaldata.map((dynamic value) => builder(value)).toList();
}

/// Converts a [Timestamp] to a [DateTime].
///
/// If the [timestamp] is null, the current date and time is returned. This
/// behavior is legacy and shouldn't be used anymore.
DateTime dateTimeFromTimestamp(dynamic timestamp) {
  final dateTime = dateTimeFromTimestampOrNull(timestamp);
  return dateTime ?? clock.now();
}

DateTime? dateTimeFromTimestampOrNull(dynamic timestamp) {
  if (timestamp == null) return null;
  final microsecondsSinceEpoch = timestamp.microsecondsSinceEpoch;
  return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
}

/// Firestore had a soft limit of 1 write per second per document. However,
/// this limit isn't mentioned in the documentation anymore. We still keep
/// the delay to be on the safe side.
///
/// See:
/// * https://stackoverflow.com/q/74454570
/// * https://firebase.google.com/docs/firestore/best-practices#updates_to_a_single_document
Future<void> waitForFirestoreWriteLimit({
  Duration delay = const Duration(milliseconds: 200),
}) async {
  await Future.delayed(delay);
}
