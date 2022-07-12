import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../presentation/register/view_model/register_controller.dart';
import '../../constants.dart';

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
        children: [
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
