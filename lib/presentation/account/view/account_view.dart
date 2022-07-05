import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/input_field.dart';
import 'package:ms_store/app/components/common/phone_form_field.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/presentation/account/controller/account_controller.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';

import '../../../app/resources/font_manger.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/values_manager.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late final GlobalKey<FormState> _formKey;
  late final AccountController _accountController;
  late final UserDataController _userDataController;

  late final TextEditingController _textEmailController;
  late final TextEditingController _textUserController;
  late final PhoneController _textPhoneController;

  late final FocusNode _emailNode;
  late final FocusNode _phoneNode;
  late final FocusNode _passwordAgainNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _accountController = Get.find();
    _userDataController = Get.find();
    _textEmailController = TextEditingController();
    _textUserController = TextEditingController();
    _textPhoneController =
        PhoneController(const PhoneNumber(isoCode: IsoCode.EG, nsn: ""));
    _textEmailController.text =
        _userDataController.userModel.value?.email ?? "";
    _textUserController.text =
        _userDataController.userModel.value?.userName ?? "";
    List<String>? phoneData =
        _userDataController.userModel.value?.phone.split(' - ');
    if (phoneData != null && phoneData.length == 2) {
      _textPhoneController.value = PhoneNumber(
          isoCode: IsoCode.values.byName(phoneData[0]), nsn: phoneData[1]);
    }

    _userDataController.userModel.value?.phone ?? "";
    _emailNode = FocusNode();
    _phoneNode = FocusNode();

    _passwordAgainNode = FocusNode();

    _accountController.setEmailEvent(_textEmailController.text);
    _accountController.setUserNameEvent(_textUserController.text);
    _accountController.setAlertPhoneEvent(_textPhoneController.value);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.updateProfile,
          style: context.textTheme.labelLarge,
        ),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        width: double.infinity,
                        color: Colors.red[200],
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Text(
                          AppStrings.noteUpdateProfile,
                          style: context.textTheme.labelMedium,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            controller: _textUserController,
                            keyBoardType: TextInputType.name,
                            nextNode: _emailNode,
                            label: AppStrings.userName,
                            prefixIcon: IconsManger.user,
                            errorText: _accountController.alertUserValid.value,
                            onChanged: (String? val) {
                              _accountController.setUserNameEvent(val ?? "");
                            },
                          ),
                          const SizedBox(height: AppSpacing.ap30),
                          Obx(
                            () => InputField(
                              enable: false,
                              controller: _textEmailController,
                              keyBoardType: TextInputType.emailAddress,
                              focusNode: _emailNode,
                              nextNode: _phoneNode,
                              prefixIcon: IconsManger.email,
                              label: "${AppStrings.emailTitle} *",
                              errorText:
                                  _accountController.alertEmailValid.value,
                              onChanged: (String? val) {
                                _accountController.setEmailEvent(val ?? "");
                              },
                            ),
                          ),
                          const SizedBox(height: AppSpacing.ap30),
                          BuildPhoneFormField(
                              phoneController: _textPhoneController,
                              phoneNode: _phoneNode,
                              onChanged: (PhoneNumber? p) {
                                _accountController.setAlertPhoneEvent(p);
                              },
                              suffix: Test(
                                accountController: _accountController,
                              )),
                          const SizedBox(height: AppSpacing.ap30),
                          Obx(() {
                            return InputField(
                              keyBoardType: TextInputType.visiblePassword,
                              nextNode: _passwordAgainNode,
                              obscureText: _accountController.obscure.value,
                              prefixIcon: IconsManger.password,
                              suffixWidget: IconButton(
                                onPressed: () {
                                  _accountController.changeObscureEvent();
                                },
                                icon: Icon(
                                  !_accountController.obscure.value
                                      ? IconsManger.visibility
                                      : IconsManger.visibilityOff,
                                  size: FontSize.s30,
                                ),
                              ),
                              label: "${AppStrings.password} *",
                              errorText:
                                  _accountController.alertPasswordValid.value,
                              onChanged: (String? val) {
                                _accountController.setPasswordEvent(val ?? "");
                              },
                            );
                          }),
                          const SizedBox(height: AppSpacing.ap30),
                          Obx(() {
                            return InputField(
                              keyBoardType: TextInputType.visiblePassword,
                              obscureText:
                                  _accountController.obscureAgain.value,
                              focusNode: _passwordAgainNode,
                              prefixIcon: IconsManger.password,
                              label: "${AppStrings.passwordAgain} *",
                              errorText: _accountController
                                  .alertPasswordAgainValid.value,
                              suffixWidget: IconButton(
                                onPressed: () {
                                  _accountController.changeObscureAgainEvent();
                                },
                                icon: Icon(
                                  !_accountController.obscureAgain.value
                                      ? IconsManger.visibility
                                      : IconsManger.visibilityOff,
                                  size: FontSize.s30,
                                ),
                              ),
                              onChanged: (String? val) {
                                _accountController
                                    .setPasswordAgainEvent(val ?? "");
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.ap30),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton(
                            onPressed: _accountController.isAllFieldsValid.value
                                ? () {
                                    //_accountController.registerEvent();
                                  }
                                : null,
                            child: Text(AppStrings.registerTitle),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Test extends StatefulWidget {
  final AccountController accountController;
  const Test({Key? key, required this.accountController}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (widget.accountController.alertPhoneValid.value == true) {
          return InkWell(
            onTap: () {
              widget.accountController.verifyPhone();
            },
            child: Text(
              "Send Code",
              style: context.textTheme.labelMedium!
                  .copyWith(color: ColorManager.primaryColor),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
