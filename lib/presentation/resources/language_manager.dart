// ignore_for_file: constant_identifier_names

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
