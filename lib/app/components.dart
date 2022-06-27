import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/font_manger.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/resources/values_manager.dart';
import '../presentation/register/view_model/register_controller.dart';
import 'constants.dart';

class BuildLogo extends StatelessWidget {
  final double? logoHeight;
  final bool isDark;
  const BuildLogo({Key? key, this.logoHeight, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(!isDark
          ? "assets/images/logo_in_light.png"
          : "assets/images/logo_in_dark.png"),
      fit: BoxFit.cover,
      height: logoHeight ?? 100,
    );
  }
}

Image logo({double? logoHeight, required bool isDark}) {
  return Image(
    image: AssetImage(!isDark
        ? "assets/images/logo_in_light.png"
        : "assets/images/logo_in_dark.png"),
    fit: BoxFit.cover,
    height: logoHeight ?? 100,
  );
}

Future<void> waitStateChanged({int? duration}) async {
  await Future.delayed(Duration(milliseconds: duration ?? 1000));
}

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.label,
    required this.themeDataText,
    required this.keyBoardType,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.nextNode,
    this.errorText,
    this.onChanged,
    required this.prefixIcon,
    this.suffixWidget,
  }) : super(key: key);

  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType keyBoardType;
  final String label;
  final FocusNode? nextNode;
  final bool obscureText;
  final IconData prefixIcon;
  final Widget? suffixWidget;
  final TextTheme themeDataText;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void dispose() {
    widget.focusNode?.dispose();
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: widget.themeDataText.labelMedium,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextNode?.requestFocus(),
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.ap8.w),
            child: Icon(
              widget.prefixIcon,
              size: FontSize.s30,
            ),
          ),
          suffixIcon: Device.get().isTablet
              ? Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: widget.suffixWidget,
                )
              : widget.suffixWidget,
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.ap8.w),
            child: Text(widget.label),
          ),
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}

class BuildPinCodeTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  const BuildPinCodeTextField(
      {Key? key, required this.onChanged, this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Icon(
            IconsManger.pin,
            size: FontSize.s30,
            color: ColorManager.darkColor,
          ),
        ),
        Expanded(
          flex: 6,
          child: PinCodeTextField(
            pinTheme: PinTheme.defaults(
              fieldHeight: 40,
              fieldWidth: 40,
              shape: PinCodeFieldShape.box,
              errorBorderColor: ColorManager.error,
              selectedColor: ColorManager.primaryColor,
              inactiveColor: ColorManager.grey,
              borderRadius: BorderRadius.circular(AppSpacing.ap14.r),
              borderWidth: AppSpacing.ap1_5.w,
            ),
            length: 5,
            textStyle: context.textTheme.labelMedium,
            keyboardType: TextInputType.number,
            obscureText: false,
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
            onChanged: onChanged,
            appContext: context,
            onSubmitted: onSubmitted,
          ),
        ),
        Expanded(
          child: SizedBox(
            width: AppSize.ap30.w,
          ),
        ),
      ],
    );
  }
}

class BuildCircularProgressIndicatorWithDownload extends StatelessWidget {
  final DownloadProgress downloadProgress;
  const BuildCircularProgressIndicatorWithDownload(
    this.downloadProgress, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
          color: ColorManager.primaryColor, value: downloadProgress.progress),
    );
  }
}

class BuildCircularProgressIndicator extends StatelessWidget {
  const BuildCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(color: ColorManager.primaryColor));
  }
}

class ErrorIcon extends StatelessWidget {
  const ErrorIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.error,
      size: FontSize.s30,
    );
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(GetPlatform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
      onPressed: () => Get.back(),
    );
  }
}

Future<void> showMyDialog(
    {required BuildContext context,
    required String title,
    required TextStyle textStyle,
    required EdgeInsetsGeometry paddingTitle,
    List<Widget>? actions,
    required List<Widget> content}) async {
  await context.showAlerts(
      title: title,
      textStyle: textStyle,
      paddingTitle: paddingTitle,
      content: content,
      actions: actions);
}

class PrivacyAndTerms extends StatelessWidget {
  final Function(dynamic value) onChanged;
  final RegisterController registerController;
  const PrivacyAndTerms(
      {Key? key, required this.onChanged, required this.registerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTileFormField(
      errorColor: ColorManager.error,
      checkColor: ColorManager.primaryColorLight,
      context: context,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RSizedBox(
            width: 1.h,
          ),
          Text(
            AppStrings.iAgreeWith,
            style: context.textTheme.labelMedium,
          ),
          Builder(builder: (context) {
            String _language = Get.locale!.languageCode;
            return TextButton(
              onPressed: () async {
                if (!await launchUrl(
                  Uri.parse(
                      '${Constants.baseUrl}/privacy_policy_$_language.html'),
                  mode: LaunchMode.inAppWebView,
                )) {
                  throw 'Could not launch url';
                }
              },
              child: Text(
                AppStrings.privacyAndTermTitle,
                style: context.textTheme.labelMedium!.copyWith(
                  color: Colors.blue[900],
                ),
              ),
            );
          })
        ],
      ),
      validator: (bool? value) {
        return registerController.alertPrivacyPolicyChecked.value;
      },
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.always,
      contentPadding: const EdgeInsets.all(1),
    );
  }
}
