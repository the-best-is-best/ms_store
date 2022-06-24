import 'package:flutter/material.dart';

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

extension ExtensionDialog on BuildContext {
  Future<void> showAlerts<T>(
      {required String title,
      required TextStyle textStyle,
      TextStyle? contentTextStyle,
      required EdgeInsetsGeometry paddingTitle,
      required List<Widget> content,
      bool barrierDismissible = false,
      List<Widget>? actions,
      Color? backgroundColor}) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: paddingTitle,
        titleTextStyle: textStyle,
        contentTextStyle: contentTextStyle ?? textStyle,
        backgroundColor: backgroundColor,
        title: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: content,
          ),
        ),
        actions: actions,
      ),
    );
  }
}

extension ExtensionBuildContext on BuildContext {
  void back() {
    Navigator.of(this).pop();
  }
}
