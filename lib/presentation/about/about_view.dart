import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/app/resources/styles_manger.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/gen/assets.gen.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.aboutTitle,
          style: context.textTheme.labelLarge,
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(AppSpacing.ap18),
        child: Column(
          children: [
            Image.asset(const $AssetsImagesGen().msStorePoster.path),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.ap18),
              child: Text(
                AppStrings.aboutUsText,
                style: getLightStyle(
                        color: ColorManager.textColor, fontSize: FontSize.s18)
                    .copyWith(height: 2),
              ),
            )
          ],
        ),
      )),
    );
  }
}
