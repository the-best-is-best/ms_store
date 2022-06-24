// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data.freezed.dart';

@freezed
class UserDataObject with _$UserDataObject {
  factory UserDataObject(
    String email,
    String password,
    String passwordAgin,
    String userName,
    String pin,
    String tokenSocial,
    int loginBySocial,
  ) = _UserDataObject;
}

@freezed
class ReviewObject with _$ReviewObject {
  factory ReviewObject(
    int userId,
    bool status,
    int productId,
    double rating,
    String comment,
  ) = _ReviewObject;
}
