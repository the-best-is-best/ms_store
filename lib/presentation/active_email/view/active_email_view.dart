import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/build_logo.dart';
import '../../../app/components.dart';
import '../../../app/components/active_code/build_pin_code.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../view_model/active_email_controller.dart';

class ActiveEmailView extends StatefulWidget {
  const ActiveEmailView({Key? key}) : super(key: key);

  @override
  State<ActiveEmailView> createState() => _ActiveEmailViewState();
}

class _ActiveEmailViewState extends State<ActiveEmailView> {
  final ActiveEmailController _activeEmailController = Get.find();
  final String email = Get.arguments['email'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const ButtonBack()),
      body: Obx(() {
        return _activeEmailController.flowState.value != null
            ? _activeEmailController.flowState.value!.getScreenWidget(
                _GetContentWidget(
                    email: email,
                    activeEmailController: _activeEmailController),
              )
            : _GetContentWidget(
                email: email, activeEmailController: _activeEmailController);
      }),
    );
  }
}

class _GetContentWidget extends StatefulWidget {
  final ActiveEmailController activeEmailController;
  final String email;
  const _GetContentWidget(
      {Key? key, required this.activeEmailController, required this.email})
      : super(key: key);

  @override
  State<_GetContentWidget> createState() => _GetContentWidgetState();
}

class _GetContentWidgetState extends State<_GetContentWidget> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
    widget.activeEmailController.setEmailEvent(widget.email);
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
                    onChanged: (String? val) {
                      widget.activeEmailController.setPinEvent(val ?? "");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpacing.ap30,
            ),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        widget.activeEmailController.isAllFieldsValid.value
                            ? () {
                                widget.activeEmailController.activeEmailEvent();
                              }
                            : null,
                    child: Text(AppStrings.continueTitle),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
