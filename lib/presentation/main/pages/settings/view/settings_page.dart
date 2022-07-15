import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/list_view.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/icons_manger.dart';
import 'package:ms_store/app/resources/routes_manger.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/main/pages/settings/view_model/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsController _settingsController;
  late final UserDataController _userDataController;

  @override
  void initState() {
    _settingsController = Get.find();
    _userDataController = Get.find();
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
                child: Obx(
                  () => ListView(
                    children: [
                      Text(
                        AppStrings.accountTitle,
                        style: themeData.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: AppSize.ap12,
                      ),
                      ListTile(
                        onTap: () {
                          initUpdateProfile();
                          Get.toNamed(Routes.accountRoute);
                        },
                        title: BuildCondition(
                          condition:
                              _userDataController.userModel.value != null,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: AppSize.ap12,
                                ),
                                Text(
                                  _userDataController.userModel.value!.userName,
                                  style: themeData.textTheme.labelMedium,
                                ),
                                const SizedBox(
                                  height: AppSize.ap12,
                                ),
                                Text(
                                  _userDataController.userModel.value!.email,
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
                                onPressed: () {
                                  initLoginModel();
                                  Get.toNamed(Routes.loginRoute,
                                      arguments: {'canBack': true});
                                },
                                child: Text(
                                  AppStrings.login,
                                  style: themeData.textTheme.labelMedium,
                                )),
                          ),
                        ),
                        trailing: BuildCondition(
                            condition:
                                _userDataController.userModel.value != null,
                            builder: (context) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.only(top: AppSize.ap16),
                                  child: ArrowIcon(
                                    settingsController: _settingsController,
                                  ));
                            },
                            fallback: (_) => const SizedBox()),
                      ),
                      const SizedBox(
                        height: AppSize.ap30,
                      ),
                      Text(
                        AppStrings.aboutTitle,
                        style: themeData.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: AppSize.ap12,
                      ),
                      BuildListTile(
                        nextPage: Routes.aboutRoute,
                        label: AppStrings.aboutUsTitle,
                      ),
                      const SizedBox(
                        height: AppSize.ap8,
                      ),
                      BuildListTile(
                        nextPage: Routes.contactUsRoute,
                        label: AppStrings.contactUsTitle,
                      ),
                      const SizedBox(
                        height: AppSize.ap30,
                      ),
                      Text(
                        AppStrings.setting,
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
                                    LangType.values[index].name.tr,
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
                          AppStrings.languageTitle,
                          style: themeData.textTheme.labelMedium,
                        ),
                        trailing: SizedBox(
                          width: 50.w,
                          child: Obx(() => Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _settingsController.language.value
                                          .toUpperCase()
                                          .tr,
                                      style: themeData.textTheme.labelSmall,
                                    ),
                                  ),
                                  Expanded(
                                    child: ArrowIcon(
                                        settingsController:
                                            _settingsController),
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
      ),
    );
  }
}

class ArrowIcon extends StatelessWidget {
  const ArrowIcon({
    Key? key,
    required SettingsController settingsController,
  })  : _settingsController = settingsController,
        super(key: key);

  final SettingsController _settingsController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Icon(_settingsController.language.value != "en"
          ? IconsManger.arrowLeft
          : IconsManger.arrowRight),
    );
  }
}
