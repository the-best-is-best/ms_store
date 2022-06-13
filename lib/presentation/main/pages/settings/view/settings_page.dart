import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/presentation/main/pages/settings/view_model/settings_controller.dart';

import '../../../../../app/app_refs.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsController _settingsController;
  @override
  void initState() {
    _settingsController = SettingsController();
    _settingsController.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: ListTileTheme(
            tileColor: ColorManager.greyLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.ap30)),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.white,
                child: ListView(
                  children: [
                    Text(
                      "Account",
                      style: themeData.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: AppSize.ap12,
                    ),
                    ListTile(
                        title: Obx(
                          () => BuildCondition(
                            condition:
                                _settingsController.userModel.value != null,
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: AppSize.ap12,
                                  ),
                                  Text(
                                    _settingsController
                                        .userModel.value!.userName,
                                    style: themeData.textTheme.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: AppSize.ap12,
                                  ),
                                  Text(
                                    _settingsController.userModel.value!.email,
                                    style: themeData.textTheme.labelSmall,
                                  ),
                                  const SizedBox(
                                    height: AppSize.ap12,
                                  ),
                                ],
                              );
                            },
                            fallback: (_) => SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Login',
                                    style: themeData.textTheme.labelMedium,
                                  )),
                            ),
                          ),
                        ),
                        trailing: Obx(
                          () => BuildCondition(
                              condition:
                                  _settingsController.userModel.value != null,
                              builder: (context) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: AppSize.ap16),
                                  child: Obx(() => Icon(
                                      _settingsController.language.value != "en"
                                          ? IconsManger.arrowLeft
                                          : IconsManger.arrowRight)),
                                );
                              },
                              fallback: (_) => const SizedBox()),
                        )),
                    const SizedBox(
                      height: AppSize.ap30,
                    ),
                    Text(
                      "About",
                      style: themeData.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: AppSize.ap12,
                    ),
                    ListTile(
                      title: Text(
                        'About Us',
                        style: themeData.textTheme.labelMedium,
                      ),
                      trailing: Obx(() => Icon(
                          _settingsController.language.value != "en"
                              ? IconsManger.arrowLeft
                              : IconsManger.arrowRight)),
                    ),
                    const SizedBox(
                      height: AppSize.ap8,
                    ),
                    ListTile(
                        title: Text(
                          'Contact Us',
                          style: themeData.textTheme.labelMedium,
                        ),
                        trailing: Obx(() => Icon(
                            _settingsController.language.value != "en"
                                ? IconsManger.arrowLeft
                                : IconsManger.arrowRight))),
                    const SizedBox(
                      height: AppSize.ap30,
                    ),
                    Text(
                      "Settings",
                      style: themeData.textTheme.labelLarge,
                    ),
                    const SizedBox(
                      height: AppSize.ap12,
                    ),
                    ListTile(
                      onTap: () {
                        Get.bottomSheet(Builder(builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              LangType.values.length,
                              (index) => ListTile(
                                onTap: LangType.values[index]
                                            .getValue()
                                            .toUpperCase() ==
                                        _settingsController.language.value
                                            .toUpperCase()
                                    ? null
                                    : () {
                                        _settingsController.changeLanguage(
                                            LangType.values[index]);
                                      },
                                title: Text(
                                  LangType.values[index].name,
                                  style: LangType.values[index]
                                              .getValue()
                                              .toUpperCase() ==
                                          _settingsController.language.value
                                              .toUpperCase()
                                      ? themeData.textTheme.labelMedium!
                                          .copyWith(color: ColorManager.grey)
                                      : themeData.textTheme.labelMedium,
                                ),
                              ),
                            ),
                          );
                        }), backgroundColor: ColorManager.white);
                      },
                      title: Text(
                        'Language',
                        style: themeData.textTheme.labelMedium,
                      ),
                      trailing: SizedBox(
                        width: 50,
                        child: Obx(() => Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _settingsController.language.value
                                        .toUpperCase(),
                                    style: themeData.textTheme.labelSmall,
                                  ),
                                ),
                                Expanded(
                                  child: Icon(
                                      _settingsController.language.value != "en"
                                          ? IconsManger.arrowLeft
                                          : IconsManger.arrowRight),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
