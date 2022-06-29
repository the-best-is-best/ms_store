import 'dart:ffi';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:phone_form_field/phone_form_field.dart';

import '../../../core/resources/strings_manager.dart';
import '../../base/base_controller.dart';
import '../../common/freezed/freezed_data.dart';

class ContactUsController extends GetxController with BaseController {
  Rx<ContactUsObject> contactUsObject = ContactUsObject("", "", "", "", "").obs;
  void setEmailEvent(String email) {
    contactUsObject.value = contactUsObject.value.copyWith(email: email);
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

  Rxn<String?> alertUserValid = Rxn<String?>();

  void setUserNameEvent(String user) {
    contactUsObject.value = contactUsObject.value.copyWith(userName: user);
    alertUserValid.value = isUserNameValidEvent(user);
    allFelidsValidEvent();
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

  Rxn<String?> alertSubjectValid = Rxn<String>();
  String? isAlertSubjectEvent(String userName) {
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

  void setAlertSubjectEvent(String subject) {
    contactUsObject.value = contactUsObject.value.copyWith(subject: subject);

    alertSubjectValid.value = isAlertSubjectEvent(subject);
    allFelidsValidEvent();
  }

  Rxn<bool?> alertPhoneValid = Rxn<bool>();

  void setAlertPhoneEvent(PhoneNumber? phone) {
    alertPhoneValid.value = PhoneNumber(
            isoCode: phone?.isoCode ?? IsoCode.EG, nsn: phone?.nsn ?? '0')
        .validate();
    String countryCode = phone?.countryCode ?? '0';
    String phoneNum = phone?.nsn ?? '0';
    contactUsObject.value =
        contactUsObject.value.copyWith(phone: "$countryCode $phoneNum");
    allFelidsValidEvent();
  }

  Rxn<String?> alertMessageValid = Rxn<String>();
  String? isAlertMessageValidEvent(String message) {
    if (message.isEmpty) {
      return AppStrings.required;
    } else {
      if (message.length < 5) {
        return AppStrings.userNameLength;
      } else {
        return null;
      }
    }
  }

  void setAlertMessageEvent(String message) {
    contactUsObject.value = contactUsObject.value.copyWith(message: message);

    alertMessageValid.value = isAlertMessageValidEvent(message);
    allFelidsValidEvent();
  }

  Rx<bool> isAllFieldsValid = Rx<bool>(false);
  void allFelidsValidEvent() {
    print(alertEmailValid.value);
    if (contactUsObject.value.email.isNotEmpty &&
        contactUsObject.value.userName.isNotEmpty &&
        contactUsObject.value.phone.isNotEmpty &&
        contactUsObject.value.subject.isNotEmpty &&
        contactUsObject.value.message.isNotEmpty) {
      if (alertEmailValid.value == null &&
          alertUserValid.value == null &&
          alertSubjectValid.value == null &&
          alertMessageValid.value == null) {
        isAllFieldsValid.value = true;
      } else {
        isAllFieldsValid.value = false;
      }
    } else {
      isAllFieldsValid.value = false;
    }
  }

  Rx<bool> isButtonClicked = Rx<bool>(false);
  void onSubmit() async {
    isButtonClicked.value = true;
    await waitStateChanged();

    isButtonClicked.value = false;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Get.snackbar(AppStrings.submitted, AppStrings.thanksForContactUs,
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
