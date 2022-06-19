import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../app/components.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../view_model/active_email_controller.dart';

class ActiveEmailView extends StatefulWidget {
  final String email = Get.arguments['email'];

  ActiveEmailView({Key? key}) : super(key: key);

  @override
  State<ActiveEmailView> createState() => _ActiveEmailViewState();
}

class _ActiveEmailViewState extends State<ActiveEmailView> {
  late final GlobalKey<FormState> _formKey;
  final ActiveEmailController _activeEmailController = Get.find();

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
    _activeEmailController.setEmailEvent(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(GetPlatform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )),
      body: Obx(() {
        return _activeEmailController.flowState.value != null
            ? _activeEmailController.flowState.value!.getScreenWidget(
                _getContentWidget(),
              )
            : _getContentWidget();
      }),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: AppSpacing.ap100.h,
            left: AppSpacing.ap14,
            right: AppSpacing.ap14),
        child: Column(
          children: [
            Center(
              child: logo(
                isDark: Get.isDarkMode,
              ),
            ),
            SizedBox(
              height: AppSpacing.ap30.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  pinCodeTextField(
                    context,
                    (String? val) {
                      _activeEmailController.setPinEvent(val ?? "");
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSpacing.ap30.h,
            ),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _activeEmailController.isAllFieldsValid.value
                        ? () {
                            _activeEmailController.activeEmailEvent();
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
