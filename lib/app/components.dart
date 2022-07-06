import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';

import '../app/resources/font_manger.dart';
import 'resources/color_manager.dart';
import 'resources/values_manager.dart';

Future<void> waitStateChanged({int? duration}) async {
  await Future.delayed(Duration(milliseconds: duration ?? 1000));
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

class BuildLinearProgressIndicator extends StatelessWidget {
  const BuildLinearProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      minHeight: AppSpacing.ap8,
      backgroundColor: ColorManager.textColor,
      valueColor: AlwaysStoppedAnimation(ColorManager.darkColor),
    );
  }
}
