import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import '../common/freezed/freezed_data.dart';
import '../../../core/resources/strings_manager.dart';

mixin BaseUserController {
  void setEmailEvent(String email) {
    userDataObject.value = userDataObject.value.copyWith(email: email);
    alertEmailValid.value = isEmailValidEvent(email);
  }

  Rxn<String?> alertEmailValid = Rxn<String>();
  String? isEmailValidEvent(String email) {
    if (email.isEmpty) {
      return AppStrings.required;
    } else {
      if (!EmailValidator.validate(email)) {
        return AppStrings.emailFormatError;
      } else {
        return null;
      }
    }
  }

  Rxn<String?> alertPasswordValid = Rxn<String>();

  String? isPasswordValidEvent(String pass, {bool isLogin = false}) {
    if (pass.isEmpty) {
      return AppStrings.required;
    } else if (pass.length < 5) {
      return AppStrings.passwordLengthError;
    } else if (!isLogin && pass != userDataObject.value.passwordAgin) {
      return AppStrings.passwordNotTheSame;
    } else {
      return null;
    }
  }

  void setPasswordLoginEvent(String password) {
    userDataObject.value = userDataObject.value.copyWith(password: password);

    alertPasswordValid.value = isPasswordValidEvent(password, isLogin: true);
  }

  void setPasswordEvent(String password) {
    userDataObject.value = userDataObject.value.copyWith(password: password);

    alertPasswordValid.value = isPasswordValidEvent(password, isLogin: false);
    alertPasswordAgainValid.value =
        isPasswordAginValidEvent(userDataObject.value.passwordAgin);
  }

  Rxn<String?> alertPasswordAgainValid = Rxn<String>();

  void setPasswordAgainEvent(String password) {
    userDataObject.value =
        userDataObject.value.copyWith(passwordAgin: password);

    alertPasswordAgainValid.value = isPasswordAginValidEvent(password);
    alertPasswordValid.value =
        isPasswordValidEvent(userDataObject.value.password, isLogin: false);
  }

  String? isPasswordAginValidEvent(String pass) {
    if (pass.isEmpty) {
      return AppStrings.required;
    } else if (pass.length < 5) {
      return AppStrings.passwordLengthError;
    } else if (pass != userDataObject.value.password) {
      print("pass : $pass - again ${userDataObject.value.password}");
      return AppStrings.passwordNotTheSame;
    } else {
      return null;
    }
  }

  Rx<UserDataObject> userDataObject =
      UserDataObject("", "", "", '', ',', '', 0).obs;
  Rx<bool> isAllFieldsValid = false.obs;
}
