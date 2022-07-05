import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/main/pages/settings/view_model/settings_controller.dart';

import '../../../app/resources/icons_manger.dart';

class BuildListTile extends StatelessWidget {
  final String nextPage;
  final String label;

  const BuildListTile({Key? key, required this.nextPage, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController _settingsController = Get.find();
    return ListTile(
        onTap: () {
          Get.toNamed(nextPage);
        },
        title: Text(
          label,
          style: context.textTheme.labelMedium,
        ),
        trailing: Icon(_settingsController.language.value != "en"
            ? IconsManger.arrowLeft
            : IconsManger.arrowRight));
  }
}
