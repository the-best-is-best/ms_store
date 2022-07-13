import 'dart:async';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/build_circular_progress_indicator.dart';
import 'package:ms_store/presentation/verify_phone/controller/verify_phone_controller.dart';

import '../../../app/components/active_code/build_pin_code.dart';
import '../../../app/components/common/build_logo.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';

class VerifyPhoneView extends StatefulWidget {
  const VerifyPhoneView({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneView> createState() => _VerifyPhoneViewState();
}

class _VerifyPhoneViewState extends State<VerifyPhoneView> {
  late final VerifyPhoneController _verifyPhoneController;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _verifyPhoneController = Get.find();
    timer = Timer.periodic(const Duration(seconds: 30),
        (Timer t) => _verifyPhoneController.back());
    _verifyPhoneController.setVerificationId(Get.arguments['verificationId']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: _GetContentWidget(verifyPhoneController: _verifyPhoneController));
  }
}

class _GetContentWidget extends StatefulWidget {
  final VerifyPhoneController verifyPhoneController;
  const _GetContentWidget({
    Key? key,
    required this.verifyPhoneController,
  }) : super(key: key);

  @override
  State<_GetContentWidget> createState() => _GetContentWidgetState();
}

class _GetContentWidgetState extends State<_GetContentWidget> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            top: AppSpacing.ap100,
            left: AppSpacing.ap14,
            right: AppSpacing.ap14),
        child: Column(
          children: [
            Center(
              child: BuildLogo(
                isDark: Get.isDarkMode,
              ),
            ),
            const SizedBox(height: AppSpacing.ap30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  BuildPinCodeTextField(
                    length: 6,
                    onChanged: (String? val) {
                      widget.verifyPhoneController.setSmsCode(val ?? "");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.ap30,
            ),
            Obx(() => BuildCondition(
                  condition: widget.verifyPhoneController.clicked.value != true,
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: Obx(() => ElevatedButton(
                            onPressed: widget.verifyPhoneController
                                    .validCodeSmsLength.value
                                ? () {
                                    widget.verifyPhoneController.sendCodeSms();
                                  }
                                : null,
                            child: Text(AppStrings.continueTitle),
                          )),
                    );
                  },
                  fallback: (_) => const BuildCircularProgressIndicator(),
                )),
          ],
        ),
      ),
    );
  }
}
