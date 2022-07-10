import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';

import '../../../app/resources/color_manager.dart';
import '../../../services/location_services.dart';
import '../../base/base_controller.dart';
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

  RxInt paymentMethod = 0.obs;
  Rx<String?> paymentMethodAlert = Rx<String?>(null);
  String address = "";
  Rx<String?> addressAlert = Rx<String?>(null);
  String country = "";
  String states = "";
  String city = "";
  Rx<String?> cscAlert = Rx<String?>(null);
  Rx<bool> allFieldsValid = Rx<bool>(false);

  void paymentMethodChange(int val) {
    paymentMethod.value = val;
    if (val == 0) {
      paymentMethodAlert.value = AppStrings.required;
    } else {
      paymentMethodAlert.value = null;
    }
    validAllFields();
  }

  void addressMethodChange(String val) {
    address = val;
    if (val.isEmpty) {
      addressAlert.value = AppStrings.required;
    } else {
      addressAlert.value = null;
    }
    validAllFields();
  }

  void countryMethodChange(String val) {
    country = val;
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void statesMethodChange(String val) {
    states = val;
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void cityMethodChange(String val) {
    city = val;
    if (val.isEmpty) {
      cscAlert.value = AppStrings.required;
    } else {
      cscAlert.value = null;
    }
    validAllFields();
  }

  void validAllFields() {
    if (paymentMethod.value != 0 &&
        address.isNotEmpty &&
        country.isNotEmpty &&
        states.isNotEmpty &&
        city.isNotEmpty) {
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
}
