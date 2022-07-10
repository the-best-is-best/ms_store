import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/presentation/checkout/widgets/controller/google_map_controller.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../services/location_services.dart';
import '../controller/checkout_controller.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({Key? key}) : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final TextEditingController textEditingController =
      Get.arguments['mapTextEditing'];

  final GoogleMapsController _googleMapsController = Get.find();
  final CheckoutController _checkoutController = Get.find();

  late final GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              initialCameraPosition: _googleMapsController.camPos.value!,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: {
                // Marker(
                //     markerId: const MarkerId('place'),
                //     icon: BitmapDescriptor.defaultMarkerWithHue(
                //         BitmapDescriptor.hueRed),
                //     position: storePlace),
                _googleMapsController.origin.value!,
              },
              onTap: (LatLng latLng) async {
                _googleMapsController.addMarker(latLng);
                String address = await _checkoutController
                    .getAddressFromLatLong(marker: latLng);
                _googleMapsController.getDirections(latLng);
                textEditingController.text = address;
              },
            ),
            // if (_googleMapsController.info.value != null)
            //   Positioned(
            //       top: 20,
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //             vertical: AppSpacing.ap4, horizontal: AppSpacing.ap8),
            //         decoration: BoxDecoration(
            //           color: ColorManager.yellow,
            //           borderRadius: BorderRadius.circular(AppSize.ap20),
            //           boxShadow: const [
            //             BoxShadow(
            //                 color: Colors.black26,
            //                 offset: Offset(0, 2),
            //                 blurRadius: 6),
            //           ],
            //         ),
            //         child: Text(
            //           '${_googleMapsController.info.value!.totalDistance} , ${_googleMapsController.info.value!.totalDuration}',
            //           style: context.textTheme.labelMedium,
            //         ),
            //       )),
          ],
        ),
      ),
    );
  }
}
