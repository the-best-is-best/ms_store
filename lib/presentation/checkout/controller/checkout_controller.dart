import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/app/constants.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/domain/use_case/paymob/buy_use_case.dart';
import 'package:ms_store/domain/use_case/paymob/get_order_id_use_case.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../domain/use_case/paymob/create_order_use_case.dart';
import '../../../domain/use_case/paymob/get_first_token_use_case.dart';
import '../../../services/location_services.dart';
import '../../base/base_controller.dart';
import '../../common/freezed/freezed_orders.dart';
import '../../common/state_renderer/state_renderer.dart';

class CheckoutController extends GetxController with BaseController {
  final UserDataController userDataController = Get.find();
  final CartController cartController = Get.find();

  final PayMobGetFirstTokenUseCase _getFirstTokenUseCase;
  final PayMobGetOrderIdUseCase _getOrderIdUseCase;
  final PayMobCreateOrderUseCase _createOrderUseCase;
  final BuyUseCase _buyUseCase;

  CheckoutController(this._getFirstTokenUseCase, this._getOrderIdUseCase,
      this._createOrderUseCase, this._buyUseCase);

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

  Rx<String?> paymentMethodAlert = Rx<String?>(null);

  Rx<String?> addressAlert = Rx<String?>(null);

  Rx<String?> cscAlert = Rx<String?>(null);
  Rx<bool> allFieldsValid = Rx<bool>(false);

  void paymentMethodChange(int val) {
    ordersObject.value = ordersObject.value.copyWith(paymentMethod: val);
    print(ordersObject.value.paymentMethod);
    if (val == 0) {
      paymentMethodAlert.value = AppStrings.required;
    } else {
      paymentMethodAlert.value = null;
    }
    validAllFields();
  }

  void setEmailEvent(String val) {
    ordersObject.value = ordersObject.value.copyWith(email: val);
  }

  Rx<String?> firstNameAlert = Rx<String?>(null);
  void addFirstName(String val) {
    ordersObject.value = ordersObject.value.copyWith(firstName: val);
    if (val.isEmpty) {
      firstNameAlert.value = AppStrings.required;
    } else {
      firstNameAlert.value = null;
    }
    validAllFields();
  }

  Rx<String?> lastNameAlert = Rx<String?>(null);
  void addLastName(String val) {
    ordersObject.value = ordersObject.value.copyWith(lastName: val);
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
      phoneValueLocal = "+$countryCode$phoneNum";

      ordersObject.value = ordersObject.value.copyWith(phone: phoneValueLocal);

      isVerifiedPhone.value = true;
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
    ordersObject.value = ordersObject.value.copyWith(address: val);
    if (val.isEmpty) {
      addressAlert.value = AppStrings.required;
    } else {
      addressAlert.value = null;
    }
    validAllFields();
  }

  void countryMethodChange(String val) {
    ordersObject.value = ordersObject.value.copyWith(country: val);
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void statesMethodChange(String val) {
    ordersObject.value = ordersObject.value.copyWith(state: val);
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void cityMethodChange(String val) {
    ordersObject.value = ordersObject.value.copyWith(city: val);
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
    int integrationId = 0;
    if (ordersObject.value.paymentMethod == 1) {
      integrationId = Constants.integrationIdCash;
    } else if (ordersObject.value.paymentMethod == 2) {
      integrationId = Constants.integrationIdCard;
    } else if (ordersObject.value.paymentMethod == 3) {
      integrationId = Constants.integrationIdKiosk;
    }

    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);

    var firstTokenResponse = await _getFirstTokenUseCase
        .execute(PayMobGetFirstTokenUseCaseInput(Constants.payMobApiKey));
    firstTokenResponse.fold((error) {
      flowState.value = LoadingState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: AppStrings.serverError);
    }, (String firstToken) async {
      // price to cents
      int price = (cartController.totalPrice * 100).toInt();
      var orderResponse = await _getOrderIdUseCase.execute(
          PayMobGetOrderIdUseCaseInput(
              authToken: firstToken, amountCents: price));
      orderResponse.fold((error) {
        flowState.value = LoadingState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: AppStrings.serverError);
      }, (int orderId) async {
        // toJson
        var orderJson = {
          'email': ordersObject.value.email,
          "first_name": ordersObject.value.firstName,
          "last_name": ordersObject.value.lastName,
          "phone_number": ordersObject.value.phone,
          "street": ordersObject.value.address,
          "country": ordersObject.value.country,
          "state": ordersObject.value.state,
          "city": ordersObject.value.city,
          "floor": "NA",
          "building": "NA",
          "apartment": "NA",
          "postal_code": "NA",
        };
        var orderCreatedResponse = await _createOrderUseCase.execute(
            PayMobCreateOrderUseCaseInput(
                authToken: firstToken,
                orderId: orderId,
                billingData: orderJson,
                amountCents: price,
                integrationId: integrationId));
        orderCreatedResponse.fold((error) {
          flowState.value = LoadingState(
              stateRendererType: StateRendererType.POPUP_ERROR_STATE,
              message: AppStrings.serverError);
        }, (lastToken) async {
          if (ordersObject.value.paymentMethod == 1) {
            var paymentResponse = await _buyUseCase.execute(
                BuyUseCaseUseCasInput(
                    authToken: lastToken,
                    source: {"identifier": "cash", "subtype": "CASH"}));
            paymentResponse.fold((l) => printError(info: l.messages),
                (r) => printInfo(info: r.toString()));
            CartController _cartController = Get.find();
            _cartController.clearData();

            flowState.value = SuccessState(
              stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
              message: AppStrings.success,
              color: ColorManager.white,
            );
          } else if (ordersObject.value.paymentMethod == 2) {
            Get.offAllNamed(Routes.payWithVisaCardView,
                arguments: {'token': lastToken});
            CartController _cartController = Get.find();
            _cartController.clearData();
          } else {
            var paymentResponse = await _buyUseCase.execute(
                BuyUseCaseUseCasInput(authToken: lastToken, source: {
              "identifier": "AGGREGATOR",
              "subtype": "AGGREGATOR"
            }));
            paymentResponse.fold((l) => printError(info: l.messages), (r) {
              CartController _cartController = Get.find();
              _cartController.clearData();
              flowState.value = SuccessState(
                stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
                message: r.toString(),
                color: ColorManager.white,
              );
            });
          }
        });
      });
    });
  }

  List<String> paymentMethods = [
    AppStrings.choosePaymentMethod,
    AppStrings.cash,
    AppStrings.creditCard,
    AppStrings.kiosk,
    //  AppStrings.payPal,
  ];
}
