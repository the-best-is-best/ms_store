import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tbib_loading_transition_button_and_social/tbib_loading_transition_button_and_social.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manger.dart';
import '../../../app/resources/values_manager.dart';
import '../../../gen/assets.gen.dart';

class BuildLoginSocialButton extends StatefulWidget {
  final String title;
  final LoadingSignButtonController controller;
  final ButtonType buttonType;
  final VoidCallback? onSubmit;

  const BuildLoginSocialButton(
      {Key? key,
      required this.title,
      required this.controller,
      required this.onSubmit,
      required this.buttonType})
      : super(key: key);

  @override
  State<BuildLoginSocialButton> createState() => _BuildLoginSocialButtonState();
}

class _BuildLoginSocialButtonState extends State<BuildLoginSocialButton> {
  @override
  Widget build(BuildContext context) {
    return LoadingSignButton(
      width: context.width,
      height: 50,
      buttonType: widget.buttonType,
      btnText: widget.title,
      fontSize: FontSize.s18,
      imageSize: AppSize.ap20,
      controller: widget.controller,
      durationSuccess: const Duration(seconds: 1),
      progressIndicatorColor: ColorManager.primaryColor,
      successWidget: Lottie.asset(
        const $AssetsJsonGen().success,
      ),
      onSubmit: widget.onSubmit,
    );
  }
}
