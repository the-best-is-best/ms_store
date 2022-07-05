import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ms_store/domain/models/users_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/base_users_controller.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';

import '../../../app/resources/strings_manager.dart';
import '../../common/freezed/freezed_data.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class AccountController extends GetxController
    with BaseController, BaseUserController {
  Rxn<String?> alertUserValid = Rxn<String?>();

  void setUserNameEvent(String user) {
    userDataObject.value = userDataObject.value.copyWith(userName: user);
    alertUserValid.value = isUserNameValidEvent(user);
    validAllFields();
  }

  String? isUserNameValidEvent(String userName) {
    if (userName.isEmpty) {
      return AppStrings.required;
    } else {
      if (userName.length < 5) {
        return AppStrings.userNameLength;
      } else {
        return null;
      }
    }
  }

  @override
  void setEmailEvent(String email) {
    super.setEmailEvent(email);
    alertEmailValid.value = isEmailValidEvent(email);
    validAllFields();
  }

  @override
  void setPasswordEvent(String password) {
    super.setPasswordEvent(password);

    if (!password.isNotEmpty) {
      alertPasswordValid.value = null;
    }
    validAllFields();
  }

  @override
  void setPasswordAgainEvent(String password) {
    super.setPasswordAgainEvent(password);
    if (!password.isNotEmpty) {
      alertPasswordAgainValid.value = null;
    }
    validAllFields();
  }

  Rx<bool> obscure = true.obs;

  void changeObscureEvent() {
    obscure.value = !obscure.value;
  }

  Rx<bool> obscureAgain = true.obs;

  void changeObscureAgainEvent() {
    obscureAgain.value = !obscureAgain.value;
  }

  Rx<bool?> alertPhoneValid = Rx<bool?>(null);
  void setAlertPhoneEvent(PhoneNumber? phone) {
    if (phone?.nsn.isNotEmpty ?? false) {
      alertPhoneValid.value = PhoneNumber(
              isoCode: phone?.isoCode ?? IsoCode.EG, nsn: phone?.nsn ?? '0')
          .validate();
      String countryCode = phone?.countryCode ?? '0';
      String phoneNum = phone?.nsn ?? '0';
      userDataObject.value =
          userDataObject.value.copyWith(phone: "+$countryCode$phoneNum");
    } else {
      userDataObject.value.copyWith(phone: "");
      alertPhoneValid.value = null;
    }
    validAllFields();
  }

  void verifyPhone() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: userDataObject.value.phone,
        verificationCompleted: (phoneAuthCredential) {
          log("sms : " + phoneAuthCredential.smsCode.toString());
        },
        verificationFailed: (ex) {
          log(ex.toString());
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {
          flowState.value = LoadingState(
              stateRendererType: StateRendererType.POPUP_ERROR_STATE,
              message: 'codeAutoRetrievalTimeout');
        },
      );
    } catch (_) {
      flowState.value = LoadingState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: AppStrings.serverError);
    }
  }

  void validAllFields() {
    UserDataObject value = userDataObject.value;
    UserDataController userDataController = Get.find();
    UserModel userData = userDataController.userModel.value!;
    if (userData.email != value.email ||
        userData.userName != value.userName ||
        userData.phone != value.phone) {
      if (value.email.isNotEmpty &&
          (alertPhoneValid.value == null || alertPhoneValid.value == true) &&
          value.userName.isNotEmpty) {
        if (alertEmailValid.value == null &&
            alertPasswordValid.value == null &&
            alertPasswordAgainValid.value == null &&
            alertUserValid.value == null) {
          isAllFieldsValid.value = true;
        } else {
          isAllFieldsValid.value = false;
        }
      } else {
        isAllFieldsValid.value = false;
      }
    } else {
      isAllFieldsValid.value = false;
    }
  }
}
