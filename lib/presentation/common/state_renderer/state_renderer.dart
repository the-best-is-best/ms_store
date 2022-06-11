// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../gen/assets.gen.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manger.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manger.dart';
import '../../../resources/values_manager.dart';

enum StateRendererType {
  POPUP_LOADING_STATE,
  POPUP_NETWORK_ERROR_STATE,
  POPUP_ERROR_STATE,
  POPUP_CHECK_EMAIL_STATE,
  POPUP_SUCCESS_STATE,
  // FULL SCREEN STATES
  FULLSCREEN_LOADING_STATE,
  FULLSCREEN_ERROR_STATE,
  FULLSCREEN_EMPTY_STATE,
  // GENERAL
  CONTENT_STATE
}

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    Key? key,
    required this.stateRendererType,
    required this.message,
    //  required this.title,
    required this.retryActionFunction,
  }) : super(key: key);

  final String message;
  // final String title;
  final Function retryActionFunction;

  final StateRendererType stateRendererType;

  Widget _getStateWidget(StateRendererType stateRendererType) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_SUCCESS_STATE:
        return _getItemsColumn([
          _getAnimatedImage(const $AssetsJsonGen().success),
          _getMessage(
            message,
          ),
          _getButton(AppStrings.ok)
        ]);
      case StateRendererType.POPUP_CHECK_EMAIL_STATE:
        return _getItemsColumn([
          _getAnimatedImage(const $AssetsJsonGen().checkEmail),
          _getMessage(
            message,
          ),
          _getButton(AppStrings.ok)
        ]);
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog([
          _getAnimatedImage(const $AssetsJsonGen().loading),
          _getMessage(message)
        ]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog([
          _getAnimatedImage(const $AssetsJsonGen().error),
          _getMessage(message),
          _getButton(
            AppStrings.ok,
          )
        ]);
      case StateRendererType.FULLSCREEN_LOADING_STATE:
        return _getItemsColumn([
          _getAnimatedImage(const $AssetsJsonGen().loading),
          _getMessage(message),
        ]);

      case StateRendererType.FULLSCREEN_ERROR_STATE:
        return _getItemsColumn([
          _getAnimatedImage(const $AssetsJsonGen().error),
          _getMessage(
            message,
          ),
          _getButton(AppStrings.errorTryAgain)
        ]);
      case StateRendererType.FULLSCREEN_EMPTY_STATE:
        return _getItemsColumn([
          _getAnimatedImage(const $AssetsJsonGen().empty),
          _getMessage(
            message,
          ),
        ]);

      case StateRendererType.POPUP_NETWORK_ERROR_STATE:
        return _getItemsColumn([
          _getAnimatedImage(const $AssetsJsonGen().connectionError),
          _getMessage(
            message,
          ),
          _getButton(AppStrings.errorTryAgain)
        ]);
      case StateRendererType.CONTENT_STATE:
        return Container();
    }
  }

  Widget _getPopUpDialog(List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.ap14.r)),
      elevation: AppSize.ap1_5,
      backgroundColor: ColorManager.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSpacing.ap14.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.ap14.h),
          child: _getDialogContext(children),
        ),
      ),
    );
  }

  Widget _getDialogContext(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return Lottie.asset(animationName,
        width: stateRendererType == StateRendererType.FULLSCREEN_EMPTY_STATE
            ? AppSize.s300
            : AppSize.s150.w,
        height: stateRendererType == StateRendererType.FULLSCREEN_EMPTY_STATE
            ? AppSize.s300
            : AppSize.s150.h);
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.ap20.h),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            fontSize: FontSize.s24,
            color: ColorManager.textColor,
          ),
        ),
      ),
    );
  }

  Widget _getButton(String buttonTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.ap18.h),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800, minWidth: 200),
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType ==
                StateRendererType.FULLSCREEN_LOADING_STATE) {
              retryActionFunction.call();
            } else {
              if (Get.isDialogOpen == true) {
                Get.back();
              }
              retryActionFunction.call();
              // popup error states

            }
          },
          child: Text(
            buttonTitle,
            style: getRegularStyle(
                fontSize: FontSize.s18, color: ColorManager.textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(stateRendererType);
  }
}
