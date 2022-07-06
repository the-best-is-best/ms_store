import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../account/controller/account_controller.dart';

class VerifyPhoneController extends GetxController {
  AccountController accountController = Get.find();

  late String verificationId;
  Rx<bool> validCodeSmsLength = Rx<bool>(false);
  Rx<bool> clicked = Rx<bool>(false);

  Rx<String> smsCode = Rx<String>('');
  void back() {
    accountController.loadingVerifyPhone.value = false;
    Get.back();
  }

  void setVerificationId(String verificationIdValue) {
    verificationId = verificationIdValue;
  }

  void setSmsCode(String code) {
    smsCode.value = code;
    checkValidation();
  }

  void checkValidation() {
    if (smsCode.value.length == 6) {
      validCodeSmsLength.value = true;
    } else {
      validCodeSmsLength.value = false;
    }
  }

  void sendCodeSms() async {
    clicked.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode.value);

      await auth.signInWithCredential(credential);
      accountController.isVerifiedPhone.value = true;
      accountController.loadingVerifyPhone.value = false;
      accountController.userDataObject.value =
          accountController.userDataObject.value.copyWith(phoneVerify: 1);
      accountController.validAllFields();
      Get.back();
      clicked.value = false;
    } catch (_) {
      clicked.value = false;
    }
  }
}
