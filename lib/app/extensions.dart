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

extension CacheDataExtension on CachedData {
  bool isValid(int expirationTimeMilliSecand) {
    int currentTimeMilliSecand = DateTime.now().millisecondsSinceEpoch;
    return currentTimeMilliSecand - cacheTime < expirationTimeMilliSecand;
  }
}
