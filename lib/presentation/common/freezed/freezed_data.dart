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
  ) = _UserDataObject;
}

// @freezed
// class LoginObject with _$LoginObject {
//   factory LoginObject(String email, String password) = _LoginObject;
// }

// @freezed
// class RegisterObject with _$RegisterObject {
//   factory RegisterObject(String email, String password, String passwordAgain,
//       String userName) = _RegisterObject;
// }

// @freezed
// class ActiveEmailObject with _$ActiveEmailObject {
//   factory ActiveEmailObject(String email, String pin) = _ActiveEmailObject;
// }

// @freezed
// class ForgetPasswordObject with _$ForgetPasswordObject {
//   factory ForgetPasswordObject(String email) = _ForgetPasswordObject;
// }

// @freezed
// class ResetPasswordObject with _$ResetPasswordObject {
//   factory ResetPasswordObject(
//           String pin, String email, String password, String passwordAgin) =
//       _ResetPasswordObject;
// }
