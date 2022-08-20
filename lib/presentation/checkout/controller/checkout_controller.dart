import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../services/location_services.dart';
import '../../base/base_controller.dart';
import '../../common/freezed/freezed_orders.dart';
import '../../common/state_renderer/state_renderer.dart';

class CheckoutController extends GetxController with BaseController {
  double? latitude;
  double? longitude;
  Future<String> getAddressFromLatLong({LatLng? marker}) async {
    Position? position;
    if (marker == null) {
      position = await getGeoLocationPosition();
    }

    latitude = position?.latitude ?? marker?.latitude;
    longitude = position?.longitude ?? marker?.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(
        position?.latitude ?? marker?.latitude ?? 0,
        position?.longitude ?? marker?.longitude ?? 0);
    Placemark place = placemarks[0];
    String addressPlace =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    addressMethodChange(addressPlace);
    return addressPlace;
  }

  Rx<OrdersObject> ordersObject =
      OrdersObject('', '', '', '', '', '', '', '', 0).obs;
  // RxInt paymentMethod = 0.obs;
  // String address = "";
  // String country = "";
  // String states = "";
  // String city = "";
  Rx<String?> paymentMethodAlert = Rx<String?>(null);

  Rx<String?> addressAlert = Rx<String?>(null);

  Rx<String?> cscAlert = Rx<String?>(null);
  Rx<bool> allFieldsValid = Rx<bool>(false);

  void paymentMethodChange(int val) {
    ordersObject = ordersObject.value.copyWith(paymentMethod: val).obs;
    if (val == 0) {
      paymentMethodAlert.value = AppStrings.required;
    } else {
      paymentMethodAlert.value = null;
    }
    validAllFields();
  }

  Rx<String?> firstNameAlert = Rx<String?>(null);
  void addFirstName(String val) {
    ordersObject = ordersObject.value.copyWith(firstName: val).obs;
    if (val.isEmpty) {
      firstNameAlert.value = AppStrings.required;
    } else {
      firstNameAlert.value = null;
    }
    validAllFields();
  }

  Rx<String?> lastNameAlert = Rx<String?>(null);
  void addLastName(String val) {
    ordersObject = ordersObject.value.copyWith(lastName: val).obs;
    if (val.isEmpty) {
      lastNameAlert.value = AppStrings.required;
    } else {
      lastNameAlert.value = null;
    }
    validAllFields();
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
      ordersObject.value =
          ordersObject.value.copyWith(phone: "+$countryCode-$phoneNum");
      phoneValueLocal = "+$countryCode$phoneNum";
    } else {
      ordersObject.value = ordersObject.value.copyWith(phone: "");
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

  void addressMethodChange(String val) {
    ordersObject = ordersObject.value.copyWith(address: val).obs;
    if (val.isEmpty) {
      addressAlert.value = AppStrings.required;
    } else {
      addressAlert.value = null;
    }
    validAllFields();
  }

  void countryMethodChange(String val) {
    ordersObject = ordersObject.value.copyWith(country: val).obs;
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void statesMethodChange(String val) {
    ordersObject = ordersObject.value.copyWith(state: val).obs;
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void cityMethodChange(String val) {
    ordersObject = ordersObject.value.copyWith(city: val).obs;
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void validAllFields() {
    if (ordersObject.value.paymentMethod != 0 &&
        ordersObject.value.firstName.isNotEmpty &&
        ordersObject.value.lastName.isNotEmpty &&
        ordersObject.value.address.isNotEmpty &&
        ordersObject.value.country.isNotEmpty &&
        ordersObject.value.state.isNotEmpty &&
        ordersObject.value.city.isNotEmpty &&
        isVerifiedPhone.value == true) {
      allFieldsValid.value = true;
    } else {
      allFieldsValid.value = false;
    }
  }

  Future buy() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);

    await waitStateChanged();
    CartController _cartController = Get.find();
    _cartController.clearData();
    flowState.value = SuccessState(
      stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
      message: AppStrings.success,
      color: ColorManager.white,
    );
  }

  List<String> paymentMethods = [
    AppStrings.choosePaymentMethod,
    AppStrings.cash,
    AppStrings.creditCard,
    AppStrings.kiosk,
    //  AppStrings.payPal,
  ];
}
