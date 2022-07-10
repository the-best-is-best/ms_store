import 'package:buildcondition/buildcondition.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/input_field.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/presentation/checkout/controller/checkout_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
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
  final CartController _cartController = Get.find();

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
      body: Obx(() => _checkoutController.flowState.value != null
          ? _checkoutController.flowState.value!.getScreenWidget(
              BuildContent(
                  checkoutController: _checkoutController,
                  mapTextEditingController: _mapTextEditingController,
                  cartController: _cartController), retryActionFunction: () {
              Get.back();
            })
          : BuildContent(
              checkoutController: _checkoutController,
              mapTextEditingController: _mapTextEditingController,
              cartController: _cartController)),
    );
  }
}

class BuildContent extends StatelessWidget {
  const BuildContent({
    Key? key,
    required CheckoutController checkoutController,
    required TextEditingController mapTextEditingController,
    required CartController cartController,
  })  : _checkoutController = checkoutController,
        _mapTextEditingController = mapTextEditingController,
        _cartController = cartController,
        super(key: key);

  final CheckoutController _checkoutController;
  final TextEditingController _mapTextEditingController;
  final CartController _cartController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.ap8, horizontal: AppSpacing.ap12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Obx(() => DropdownButton<int>(
                hint: Text(
                  'Choose Payment method',
                  style: context.textTheme.labelMedium,
                ),
                isExpanded: true,
                value: _checkoutController.paymentMethod.value,
                items: [
                  DropdownMenuItem<int>(
                    value: 0,
                    child: Text(
                      'Choose Payment Methods',
                      style: context.textTheme.labelSmall,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      'Payment cash',
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                ],
                onChanged: (int? val) {
                  _checkoutController.paymentMethodChange(val ?? 0);
                })),
            Obx(() => BuildCondition(
                  condition: _checkoutController
                          .paymentMethodAlert.value?.isNotEmpty ??
                      false,
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_checkoutController.paymentMethodAlert.value!,
                        style: context.textTheme.labelMedium!
                            .copyWith(color: ColorManager.error)),
                  ),
                )),
            const SizedBox(height: 50),
            Obx(() => InputField(
                  controller: _mapTextEditingController,
                  label: AppStrings.address,
                  keyBoardType: TextInputType.none,
                  prefixIcon: IconsManger.map,
                  errorText: _checkoutController.addressAlert.value,
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
                        // initDirectionRepository();
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
                )),
            const SizedBox(height: 50),
            CSCPicker(
              onCountryChanged: (value) {
                _checkoutController.countryMethodChange(value);
              },
              onStateChanged: (value) {
                _checkoutController.statesMethodChange(value ?? "");
              },
              onCityChanged: (value) {
                _checkoutController.cityMethodChange(value ?? "");
              },
            ),
            Obx(() => BuildCondition(
                  condition:
                      _checkoutController.cscAlert.value?.isNotEmpty ?? false,
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_checkoutController.cscAlert.value!,
                        style: context.textTheme.labelMedium!
                            .copyWith(color: ColorManager.error)),
                  ),
                )),
            const SizedBox(height: AppSize.ap20),
            SizedBox(
              width: context.width,
              child: Obx(() => ElevatedButton(
                  onPressed: _checkoutController.allFieldsValid.value == false
                      ? null
                      : () async {
                          await _checkoutController.buy();
                          Get.back();
                        },
                  child: Text('Buy ${_cartController.totalPrice}'))),
            ),
          ],
        ),
      ),
    );
  }
}
