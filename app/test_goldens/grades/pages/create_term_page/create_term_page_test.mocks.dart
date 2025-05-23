// Mocks generated by Mockito 5.4.5 from annotations
// in sharezone/test_goldens/grades/pages/create_term_page/create_term_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:analytics/src/analytics/analytics.dart' as _i12;
import 'package:crash_analytics/src/crash_analytics.dart' as _i9;
import 'package:fast_immutable_collections/fast_immutable_collections.dart'
    as _i4;
import 'package:flutter/material.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;
import 'package:rxdart/rxdart.dart' as _i2;
import 'package:sharezone/grades/grades_service/grades_service.dart' as _i3;
import 'package:sharezone/grades/models/grade_id.dart' as _i7;
import 'package:sharezone/grades/models/subject_id.dart' as _i5;
import 'package:sharezone/grades/models/term_id.dart' as _i6;

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

class _FakeBehaviorSubject_0<T> extends _i1.SmartFake
    implements _i2.BehaviorSubject<T> {
  _FakeBehaviorSubject_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeTermRef_1 extends _i1.SmartFake implements _i3.TermRef {
  _FakeTermRef_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGradeRef_2 extends _i1.SmartFake implements _i3.GradeRef {
  _FakeGradeRef_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeIList_3<T> extends _i1.SmartFake implements _i4.IList<T> {
  _FakeIList_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);

  @override
  String toString([bool? prettyPrint]) => super.toString();
}

class _FakeGradeTypeId_4 extends _i1.SmartFake implements _i3.GradeTypeId {
  _FakeGradeTypeId_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSubjectId_5 extends _i1.SmartFake implements _i5.SubjectId {
  _FakeSubjectId_5(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [GradesService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGradesService extends _i1.Mock implements _i3.GradesService {
  @override
  _i2.BehaviorSubject<_i4.IList<_i3.TermResult>> get terms =>
      (super.noSuchMethod(
            Invocation.getter(#terms),
            returnValue: _FakeBehaviorSubject_0<_i4.IList<_i3.TermResult>>(
              this,
              Invocation.getter(#terms),
            ),
            returnValueForMissingStub:
                _FakeBehaviorSubject_0<_i4.IList<_i3.TermResult>>(
                  this,
                  Invocation.getter(#terms),
                ),
          )
          as _i2.BehaviorSubject<_i4.IList<_i3.TermResult>>);

  @override
  _i3.TermRef addTerm({
    required String? name,
    required _i3.GradeTypeId? finalGradeType,
    required _i3.GradingSystem? gradingSystem,
    required bool? isActiveTerm,
    _i4.IMap<_i3.GradeTypeId, _i3.Weight>? gradeTypeWeights,
    _i6.TermId? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#addTerm, [], {
              #name: name,
              #finalGradeType: finalGradeType,
              #gradingSystem: gradingSystem,
              #isActiveTerm: isActiveTerm,
              #gradeTypeWeights: gradeTypeWeights,
              #id: id,
            }),
            returnValue: _FakeTermRef_1(
              this,
              Invocation.method(#addTerm, [], {
                #name: name,
                #finalGradeType: finalGradeType,
                #gradingSystem: gradingSystem,
                #isActiveTerm: isActiveTerm,
                #gradeTypeWeights: gradeTypeWeights,
                #id: id,
              }),
            ),
            returnValueForMissingStub: _FakeTermRef_1(
              this,
              Invocation.method(#addTerm, [], {
                #name: name,
                #finalGradeType: finalGradeType,
                #gradingSystem: gradingSystem,
                #isActiveTerm: isActiveTerm,
                #gradeTypeWeights: gradeTypeWeights,
                #id: id,
              }),
            ),
          )
          as _i3.TermRef);

  @override
  _i3.TermRef term(_i6.TermId? id) =>
      (super.noSuchMethod(
            Invocation.method(#term, [id]),
            returnValue: _FakeTermRef_1(this, Invocation.method(#term, [id])),
            returnValueForMissingStub: _FakeTermRef_1(
              this,
              Invocation.method(#term, [id]),
            ),
          )
          as _i3.TermRef);

  @override
  _i3.GradeRef grade(_i7.GradeId? id) =>
      (super.noSuchMethod(
            Invocation.method(#grade, [id]),
            returnValue: _FakeGradeRef_2(this, Invocation.method(#grade, [id])),
            returnValueForMissingStub: _FakeGradeRef_2(
              this,
              Invocation.method(#grade, [id]),
            ),
          )
          as _i3.GradeRef);

  @override
  _i3.PossibleGradesResult getPossibleGrades(
    _i3.GradingSystem? gradingSystem,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#getPossibleGrades, [gradingSystem]),
            returnValue: _i8.dummyValue<_i3.PossibleGradesResult>(
              this,
              Invocation.method(#getPossibleGrades, [gradingSystem]),
            ),
            returnValueForMissingStub: _i8.dummyValue<_i3.PossibleGradesResult>(
              this,
              Invocation.method(#getPossibleGrades, [gradingSystem]),
            ),
          )
          as _i3.PossibleGradesResult);

  @override
  _i4.IList<_i3.GradeType> getPossibleGradeTypes() =>
      (super.noSuchMethod(
            Invocation.method(#getPossibleGradeTypes, []),
            returnValue: _FakeIList_3<_i3.GradeType>(
              this,
              Invocation.method(#getPossibleGradeTypes, []),
            ),
            returnValueForMissingStub: _FakeIList_3<_i3.GradeType>(
              this,
              Invocation.method(#getPossibleGradeTypes, []),
            ),
          )
          as _i4.IList<_i3.GradeType>);

  @override
  _i3.GradeTypeId addCustomGradeType({
    required String? displayName,
    _i3.GradeTypeId? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#addCustomGradeType, [], {
              #displayName: displayName,
              #id: id,
            }),
            returnValue: _FakeGradeTypeId_4(
              this,
              Invocation.method(#addCustomGradeType, [], {
                #displayName: displayName,
                #id: id,
              }),
            ),
            returnValueForMissingStub: _FakeGradeTypeId_4(
              this,
              Invocation.method(#addCustomGradeType, [], {
                #displayName: displayName,
                #id: id,
              }),
            ),
          )
          as _i3.GradeTypeId);

  @override
  void editCustomGradeType({
    required _i3.GradeTypeId? id,
    required String? displayName,
  }) => super.noSuchMethod(
    Invocation.method(#editCustomGradeType, [], {
      #id: id,
      #displayName: displayName,
    }),
    returnValueForMissingStub: null,
  );

  @override
  void deleteCustomGradeType(_i3.GradeTypeId? id) => super.noSuchMethod(
    Invocation.method(#deleteCustomGradeType, [id]),
    returnValueForMissingStub: null,
  );

  @override
  _i5.SubjectId addSubject(
    _i3.SubjectInput? subjectInput, {
    _i5.SubjectId? id,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#addSubject, [subjectInput], {#id: id}),
            returnValue: _FakeSubjectId_5(
              this,
              Invocation.method(#addSubject, [subjectInput], {#id: id}),
            ),
            returnValueForMissingStub: _FakeSubjectId_5(
              this,
              Invocation.method(#addSubject, [subjectInput], {#id: id}),
            ),
          )
          as _i5.SubjectId);

  @override
  _i4.IList<_i3.Subject> getSubjects() =>
      (super.noSuchMethod(
            Invocation.method(#getSubjects, []),
            returnValue: _FakeIList_3<_i3.Subject>(
              this,
              Invocation.method(#getSubjects, []),
            ),
            returnValueForMissingStub: _FakeIList_3<_i3.Subject>(
              this,
              Invocation.method(#getSubjects, []),
            ),
          )
          as _i4.IList<_i3.Subject>);

  @override
  _i3.Subject? getSubject(_i5.SubjectId? id) =>
      (super.noSuchMethod(
            Invocation.method(#getSubject, [id]),
            returnValueForMissingStub: null,
          )
          as _i3.Subject?);
}

/// A class which mocks [CrashAnalytics].
///
/// See the documentation for Mockito's code generation for more information.
class MockCrashAnalytics extends _i1.Mock implements _i9.CrashAnalytics {
  @override
  set enableInDevMode(bool? _enableInDevMode) => super.noSuchMethod(
    Invocation.setter(#enableInDevMode, _enableInDevMode),
    returnValueForMissingStub: null,
  );

  @override
  void crash() => super.noSuchMethod(
    Invocation.method(#crash, []),
    returnValueForMissingStub: null,
  );

  @override
  _i10.Future<void> recordFlutterError(_i11.FlutterErrorDetails? details) =>
      (super.noSuchMethod(
            Invocation.method(#recordFlutterError, [details]),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);

  @override
  _i10.Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    bool? fatal = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #recordError,
              [exception, stack],
              {#fatal: fatal},
            ),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);

  @override
  void log(String? msg) => super.noSuchMethod(
    Invocation.method(#log, [msg]),
    returnValueForMissingStub: null,
  );

  @override
  _i10.Future<void> setCustomKey(String? key, dynamic value) =>
      (super.noSuchMethod(
            Invocation.method(#setCustomKey, [key, value]),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);

  @override
  _i10.Future<void> setUserIdentifier(String? identifier) =>
      (super.noSuchMethod(
            Invocation.method(#setUserIdentifier, [identifier]),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);

  @override
  _i10.Future<void> setCrashAnalyticsEnabled(bool? enabled) =>
      (super.noSuchMethod(
            Invocation.method(#setCrashAnalyticsEnabled, [enabled]),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);
}

/// A class which mocks [Analytics].
///
/// See the documentation for Mockito's code generation for more information.
class MockAnalytics extends _i1.Mock implements _i12.Analytics {
  @override
  void log(_i12.AnalyticsEvent? event) => super.noSuchMethod(
    Invocation.method(#log, [event]),
    returnValueForMissingStub: null,
  );

  @override
  void setAnalyticsCollectionEnabled(bool? value) => super.noSuchMethod(
    Invocation.method(#setAnalyticsCollectionEnabled, [value]),
    returnValueForMissingStub: null,
  );

  @override
  _i10.Future<void> logSignUp({required String? signUpMethod}) =>
      (super.noSuchMethod(
            Invocation.method(#logSignUp, [], {#signUpMethod: signUpMethod}),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);

  @override
  _i10.Future<void> setCurrentScreen({required String? screenName}) =>
      (super.noSuchMethod(
            Invocation.method(#setCurrentScreen, [], {#screenName: screenName}),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);

  @override
  _i10.Future<void> setUserProperty({
    required String? name,
    required String? value,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#setUserProperty, [], {
              #name: name,
              #value: value,
            }),
            returnValue: _i10.Future<void>.value(),
            returnValueForMissingStub: _i10.Future<void>.value(),
          )
          as _i10.Future<void>);
}
