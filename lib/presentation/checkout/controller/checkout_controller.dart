import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/location_services.dart';
import '../../base/base_controller.dart';

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
    String address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return address;
  }
}
