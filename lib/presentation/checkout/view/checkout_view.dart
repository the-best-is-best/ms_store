import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/input_field.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/presentation/checkout/controller/checkout_controller.dart';

import '../../../app/di.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  final TextEditingController _mapTextEditingController =
      TextEditingController();
  final CheckoutController _checkoutController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.checkout,
          style: context.textTheme.labelLarge,
        ),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.ap8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(
                controller: _mapTextEditingController,
                label: AppStrings.address,
                keyBoardType: TextInputType.none,
                prefixIcon: IconsManger.map,
                suffixWidget: IconButton(
                  icon: Icon(
                    IconsManger.edit,
                    size: FontSize.s30,
                  ),
                  onPressed: () async {
                    _mapTextEditingController.text =
                        await _checkoutController.getAddressFromLatLong();
                    if (_mapTextEditingController.text == "") {
                      return;
                    } else {
                      initDirectionRepository();
                      Get.toNamed(Routes.googleMapViewRoute, arguments: {
                        'mapTextEditing': _mapTextEditingController
                      });
                    }
                  },
                ),
                onTap: () async {
                  _mapTextEditingController.text =
                      await _checkoutController.getAddressFromLatLong();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
