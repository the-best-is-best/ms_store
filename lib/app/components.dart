import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/font_manger.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presentation/register/view_model/register_controller.dart';
import 'constants.dart';

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
