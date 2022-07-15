import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/main/pages/settings/view_model/settings_controller.dart';

import '../../../app/resources/icons_manger.dart';

class BuildListTile extends StatefulWidget {
  final String nextPage;
  final String label;

  const BuildListTile({Key? key, required this.nextPage, required this.label})
      : super(key: key);

  @override
  State<BuildListTile> createState() => _BuildListTileState();
}

class _BuildListTileState extends State<BuildListTile> {
  final SettingsController _settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListTile(
        onTap: () {
          Get.toNamed(widget.nextPage);
        },
        title: Text(
          widget.label,
          style: context.textTheme.labelMedium,
        ),
        trailing: Icon(_settingsController.language.value != "en"
            ? IconsManger.arrowLeft
            : IconsManger.arrowRight)));
  }
}
