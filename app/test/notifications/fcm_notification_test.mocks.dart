// Mocks generated by Mockito 5.4.5 from annotations
// in sharezone/test/notifications/fcm_notification_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;
import 'package:sharezone/util/notification_token_adder.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [NotificationTokenAdderApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationTokenAdderApi extends _i1.Mock
    implements _i2.NotificationTokenAdderApi {
  @override
  String get vapidKey =>
      (super.noSuchMethod(
            Invocation.getter(#vapidKey),
            returnValue: _i3.dummyValue<String>(
              this,
              Invocation.getter(#vapidKey),
            ),
            returnValueForMissingStub: _i3.dummyValue<String>(
              this,
              Invocation.getter(#vapidKey),
            ),
          )
          as String);

  @override
  _i4.Future<String?> getFCMToken() =>
      (super.noSuchMethod(
            Invocation.method(#getFCMToken, []),
            returnValue: _i4.Future<String?>.value(),
            returnValueForMissingStub: _i4.Future<String?>.value(),
          )
          as _i4.Future<String?>);

  @override
  _i4.Future<void> tryAddTokenToDatabase(String? token) =>
      (super.noSuchMethod(
            Invocation.method(#tryAddTokenToDatabase, [token]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<List<String>> getUserTokensFromDatabase() =>
      (super.noSuchMethod(
            Invocation.method(#getUserTokensFromDatabase, []),
            returnValue: _i4.Future<List<String>>.value(<String>[]),
            returnValueForMissingStub: _i4.Future<List<String>>.value(
              <String>[],
            ),
          )
          as _i4.Future<List<String>>);
}
