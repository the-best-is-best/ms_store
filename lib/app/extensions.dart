import 'dart:ffi';

import 'package:flutter/material.dart';

import '../domain/models/cache/cache_data.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return "";
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orEmpty() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullDouble on double? {
  double orEmpty() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension NonNullNum on num? {
  num orEmpty() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

enum LangType { ENGLISH, ARABIC }

extension LangTypeExtension on LangType {
  String getValue() {
    switch (this) {
      case LangType.ENGLISH:
        return "en";
      case LangType.ARABIC:
        return "ar";
    }
  }
}

extension ExtensionGetThemeData on BuildContext {
  double get getHeight => MediaQuery.of(this).size.height;
  double get getWidth => MediaQuery.of(this).size.width;
  TextTheme get getThemeDataText => Theme.of(this).textTheme;
}
