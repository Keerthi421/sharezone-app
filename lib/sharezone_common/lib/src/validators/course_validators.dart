// Copyright (c) 2022 Sharezone UG (haftungsbeschränkt)
// Licensed under the EUPL-1.2-or-later.
//
// You may obtain a copy of the Licence at:
// https://joinup.ec.europa.eu/software/page/eupl
//
// SPDX-License-Identifier: EUPL-1.2

import 'dart:async';
import '../validator.dart';

mixin CourseValidators {
  final validateSubject = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (NotEmptyOrNullValidator(name).isValid()) {
        sink.add(name);
      } else {
        sink.addError(TextValidationException(emptySubjectUserMessage));
      }
    },
  );

  static const emptySubjectUserMessage = "Bitte gib ein Fach an!";
}
