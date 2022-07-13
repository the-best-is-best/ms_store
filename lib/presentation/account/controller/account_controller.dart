import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/app/resources/routes_manger.dart';
import 'package:ms_store/domain/models/users_model.dart';
import 'package:ms_store/domain/use_case/users_case/delete_user_case.dart';
import 'package:ms_store/domain/use_case/users_case/update_user_data_case.dart';
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
  final UpdateUserDataUserCase _updateUserDataUserCase;
  final DeleteUserCase _deleteUserCase;
  AccountController(this._updateUserDataUserCase, this._deleteUserCase);
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookAuth.instance;

  Rxn<String?> alertUserValid = Rxn<String?>();
  UserDataController userDataController = Get.find();

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

  String phoneValueLocal = "";
  Rx<bool?> alertPhoneValid = Rx<bool?>(null);
  void setAlertPhoneEvent(PhoneNumber? phone) {
    if (phone?.nsn.isNotEmpty ?? false) {
      alertPhoneValid.value = PhoneNumber(
              isoCode: phone?.isoCode ?? IsoCode.EG, nsn: phone?.nsn ?? '0')
          .validate();
      String countryCode = phone?.countryCode ?? '0';
      String phoneNum = phone?.nsn ?? '0';
      userDataObject.value =
          userDataObject.value.copyWith(phone: "+$countryCode-$phoneNum");
      phoneValueLocal = "+$countryCode$phoneNum";
      if (userDataController.userModel.value!.phone ==
              userDataObject.value.phone &&
          userDataController.userModel.value!.phoneVerify == 1) {
        userDataObject.value = userDataObject.value.copyWith(phoneVerify: 1);

        isVerifiedPhone.value = true;
      } else {
        isVerifiedPhone.value = false;
      }
    } else {
      userDataObject.value = userDataObject.value.copyWith(phone: "");
      alertPhoneValid.value = null;
      phoneValueLocal = "";
    }
    validAllFields();
  }

  Rx<bool> loadingVerifyPhone = Rx<bool>(false);
  Rx<bool> isVerifiedPhone = Rx<bool>(false);
  void verifyPhone() async {
    if (phoneValueLocal.isNotEmpty) {
      loadingVerifyPhone.value = true;
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.verifyPhoneNumber(
          phoneNumber: phoneValueLocal,
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: (ex) {
            log(ex.toString());
            loadingVerifyPhone.value = false;
          },
          codeSent: (String verificationId, int? resendToken) {
            Get.toNamed(Routes.verifyPhoneRoute,
                arguments: {'verificationId': verificationId});
          },
          codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {},
        );
      } catch (_) {
        flowState.value = LoadingState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: AppStrings.serverError);
      }
    }
  }

  void validAllFields() {
    UserDataObject value = userDataObject.value;

    UserModel userData = userDataController.userModel.value!;
    if (userData.email != value.email ||
        userData.userName != value.userName ||
        userData.phone != value.phone ||
        value.phoneVerify != userData.phoneVerify) {
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

  void updateUserData() async {
    UserDataObject value = userDataObject.value;

    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _updateUserDataUserCase.execute(
        UpdateUserDataUserCaseInput(
            id: userDataController.userModel.value!.id,
            userName: value.userName,
            phone: value.phone,
            phoneVerify: value.phoneVerify,
            password: value.password));
    await waitStateChanged();
    result.fold((failure) {
      if (failure.statusCode == -6) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
            message: failure.messages,
            color: Colors.white);
      } else {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }
    }, (data) async {
      userDataController.userModel.value!.userName = value.userName;
      userDataController.userModel.value!.phone = value.phone;
      userDataController.userModel.value!.phoneVerify = value.phoneVerify;
      await AppPrefs().updateUserData(userDataController.userModel.value!);
      flowState.value = SuccessState(
          stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
          message: AppStrings.passwordChanged,
          color: Colors.white);
      validAllFields();
      flowState.value = ContentState();
    });
  }

  void logout() async {
    if (userDataController.userModel.value!.loginBySocial == 1) {
      googleSignIn.signOut();
    } else if (userDataController.userModel.value!.loginBySocial == 2) {
      facebookSignIn.logOut();
    }
    await AppPrefs().clearUserData();
    await AppPrefs().clearCacheData();
    Get.back();
  }

  void delete() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _deleteUserCase.execute(DeleteUserCaseInput(
      userDataController.userModel.value!.id,
    ));
    await waitStateChanged();
    result.fold((failure) {
      if (failure.statusCode == -6) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
            message: failure.messages,
            color: Colors.white);
      } else {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }
    }, (data) async {
      flowState.value = SuccessState(
          stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
          message: AppStrings.passwordChanged,
          color: Colors.white);

      flowState.value = ContentState();
      logout();
    });
  }
}
