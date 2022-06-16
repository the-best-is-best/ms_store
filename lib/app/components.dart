import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/font_manger.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/resources/values_manager.dart';

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
  await Future.delayed(Duration(milliseconds: duration ?? 1));
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
    print(widget.themeDataText.labelMedium);
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

Widget pinCodeTextField(BuildContext context, ValueChanged<String> onChanged,
    {ValueChanged<String>? onSubmitted}) {
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
          textStyle: context.getThemeDataText.labelMedium,
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
