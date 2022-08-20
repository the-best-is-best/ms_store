import 'package:buildcondition/buildcondition.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/input_field.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/checkout/controller/checkout_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';
import '../../../app/components/common/phone_form_field.dart';
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
  final UserDataController _userDataController = Get.find();
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  PhoneController _phoneTextEditingController =
      PhoneController(const PhoneNumber(isoCode: IsoCode.EG, nsn: ""));

  @override
  void initState() {
    _firstNameTextEditingController.text =
        _userDataController.userModel.value!.userName.split(' ')[0];
    _lastNameTextEditingController.text =
        _userDataController.userModel.value!.userName.split(' ')[1];
    _emailTextEditingController.text =
        _userDataController.userModel.value!.email;
    List<String>? phoneData =
        _userDataController.userModel.value?.phone.split('-');
    if (phoneData != null && phoneData.length == 2) {
      _phoneTextEditingController = PhoneController(
          PhoneNumber.fromCountryCode(phoneData[0], phoneData[1]));
    } else {
      _phoneTextEditingController =
          PhoneController(const PhoneNumber(isoCode: IsoCode.EG, nsn: ""));
    }
    _checkoutController.setEmailEvent(_emailTextEditingController.text);
    _checkoutController.addFirstName(_firstNameTextEditingController.text);
    _checkoutController.addLastName(_lastNameTextEditingController.text);
    _checkoutController.setAlertPhoneEvent(_phoneTextEditingController.value);

    super.initState();
  }

  final FocusNode _lastName = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _address = FocusNode();

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
                cartController: _cartController,
                lastName: _lastName,
                phoneNode: _phoneNode,
                address: _address,
                emailTextEditingController: _emailTextEditingController,
                firstNameTextEditingController: _firstNameTextEditingController,
                lastNameTextEditingController: _lastNameTextEditingController,
                phoneTextEditingController: _phoneTextEditingController,
              ), retryActionFunction: () {
              Get.back();
            })
          : BuildContent(
              checkoutController: _checkoutController,
              mapTextEditingController: _mapTextEditingController,
              cartController: _cartController,
              phoneNode: _phoneNode,
              lastName: _lastName,
              address: _address,
              firstNameTextEditingController: _firstNameTextEditingController,
              lastNameTextEditingController: _lastNameTextEditingController,
              phoneTextEditingController: _phoneTextEditingController,
              emailTextEditingController: _emailTextEditingController,
            )),
    );
  }
}

class BuildContent extends StatelessWidget {
  const BuildContent({
    Key? key,
    required CheckoutController checkoutController,
    required TextEditingController mapTextEditingController,
    required CartController cartController,
    required this.phoneNode,
    required this.lastName,
    required this.address,
    required this.firstNameTextEditingController,
    required this.lastNameTextEditingController,
    required this.emailTextEditingController,
    required this.phoneTextEditingController,
  })  : _checkoutController = checkoutController,
        _mapTextEditingController = mapTextEditingController,
        _cartController = cartController,
        super(key: key);

  final CheckoutController _checkoutController;
  final TextEditingController _mapTextEditingController;
  final CartController _cartController;
  final FocusNode phoneNode;
  final FocusNode lastName;
  final FocusNode address;
  final TextEditingController firstNameTextEditingController;
  final TextEditingController lastNameTextEditingController;
  final TextEditingController emailTextEditingController;
  final PhoneController phoneTextEditingController;
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
                  AppStrings.choosePaymentMethod,
                  style: context.textTheme.labelMedium,
                ),
                isExpanded: true,
                value: _checkoutController.ordersObject.value.paymentMethod,
                items: [
                  ..._checkoutController.paymentMethods
                      .asMap()
                      .map((index, element) => MapEntry(
                          index,
                          DropdownMenuItem(
                            onTap: index == 0 ? null : () {},
                            value: index,
                            child: Text(
                              element,
                              style: context.textTheme.labelMedium,
                            ),
                          )))
                      .values
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
            const SizedBox(height: 20),
            InputField(
              controller: firstNameTextEditingController,
              label: AppStrings.firstName,
              keyBoardType: TextInputType.name,
              prefixIcon: IconsManger.user,
              onChanged: (value) {
                _checkoutController.addFirstName(value);
              },
              errorText: _checkoutController.firstNameAlert.value,
              nextNode: lastName,
            ),
            const SizedBox(height: 20),
            InputField(
              controller: lastNameTextEditingController,
              label: AppStrings.lastName,
              keyBoardType: TextInputType.name,
              prefixIcon: IconsManger.user,
              onChanged: (value) {
                _checkoutController.addLastName(value);
              },
              errorText: _checkoutController.lastNameAlert.value,
              focusNode: lastName,
              nextNode: phoneNode,
            ),
            const SizedBox(height: 20),
            BuildPhoneFormField(
              phoneController: phoneTextEditingController,
              phoneNode: phoneNode,
              onChanged: (PhoneNumber? p) {
                _checkoutController.setAlertPhoneEvent(p);
              },
              suffix: SendCode(
                checkoutController: _checkoutController,
              ),
              nextNode: address,
            ),
            const SizedBox(height: 20),
            Obx(
              () => InputField(
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
                focusNode: address,
              ),
            ),
            const SizedBox(height: 20),
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

class SendCode extends StatefulWidget {
  final CheckoutController checkoutController;
  const SendCode({Key? key, required this.checkoutController})
      : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (widget.checkoutController.alertPhoneValid.value == true) {
          if (widget.checkoutController.loadingVerifyPhone.value == false) {
            if (widget.checkoutController.isVerifiedPhone.value == false) {
              return Icon(
                IconsManger.error,
                size: FontSize.s30,
                color: ColorManager.error,
              );
            } else {
              return Icon(
                IconsManger.success,
                size: FontSize.s30,
                color: ColorManager.darkColor,
              );
            }
          } else {
            return const SizedBox(
              height: 20,
              width: 20,
              child:
                  CircularProgressIndicator(color: ColorManager.primaryColor),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
