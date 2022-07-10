import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ms_store/domain/models/directions_model.dart';
import 'package:ms_store/presentation/checkout/controller/checkout_controller.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../repository/repository_map.dart';

class GoogleMapsController extends GetxController {
  final DirectionsRepository _directionsRepository;
  GoogleMapsController(this._directionsRepository);

  final CheckoutController _checkoutController = Get.find();
  Rx<Marker?> origin = Rx<Marker?>(null);
  Rx<CameraPosition?> camPos = Rx<CameraPosition?>(null);
  Rx<Directions?> info = Rx<Directions?>(null);

  @override
  void onInit() {
    camPos.value = CameraPosition(
        target: LatLng(
          _checkoutController.latitude!,
          _checkoutController.longitude!,
        ),
        zoom: 12);
    origin.value = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: InfoWindow(title: AppStrings.deliveryAddress),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(
            _checkoutController.latitude!, _checkoutController.longitude!));

    super.onInit();
  }

  void addMarker(LatLng latLng) {
    origin.value = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: InfoWindow(title: AppStrings.deliveryAddress),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: latLng);
  }

  void getDirections(LatLng destination) async {
    info.value = await _directionsRepository.getDirections(
        origin: origin.value!.position, destination: destination);
  }
}
