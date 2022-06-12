import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'state_renderer.dart';
import '../../../core/resources/color_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  Color? getBackgroundColor();
  String getMessage();
}

// loading state (popup - full screen)

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  final Color? color;
  LoadingState(
      {required this.stateRendererType, required this.message, this.color});
  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;

  @override
  Color? getBackgroundColor() => color;
}

class SuccessState extends FlowState {
  final StateRendererType stateRendererType;
  final Color? color;

  final String message;

  SuccessState(
      {required this.message, required this.stateRendererType, this.color});
  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;

  @override
  Color? getBackgroundColor() => color;
}

// error state (popup - full screen)
class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;
  final Color? color;

  ErrorState(
      {required this.stateRendererType, required this.message, this.color});

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getMessage() => message;
  @override
  Color? getBackgroundColor() => color;
}

// content state
class ContentState extends FlowState {
  final Color? color;

  ContentState({this.color});
  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_STATE;

  @override
  String getMessage() => "";
  @override
  Color? getBackgroundColor() => color;
}

// error state (popup - full screen)
class EmptyState extends FlowState {
  final String message;
  final Color? color;

  EmptyState({required this.message, this.color});

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULLSCREEN_EMPTY_STATE;

  @override
  String getMessage() => message;
  @override
  Color? getBackgroundColor() => color;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(Widget contentScreenWidget,
      {Function? retryActionFunction}) {
    // ignore: avoid_print
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            // Show popup loading
            // Show content screen
            showPopup(getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            // full screen loading state
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: () {});
          }
        }
      case SuccessState:
        dismissDialog();

        // Show popup loading
        // Show content screen
        showPopup(getStateRendererType(), getMessage(),
            retryActionFunction: retryActionFunction ?? () {});
        return contentScreenWidget;

      case ErrorState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            dismissDialog();

            // Show popup loading
            // Show content screen
            showPopup(getStateRendererType(), getMessage(),
                retryActionFunction: retryActionFunction ?? () {});
            return contentScreenWidget;
          } else if (getStateRendererType() ==
              StateRendererType.POPUP_NETWORK_ERROR_STATE) {
            dismissDialog();

            // Show popup loading
            // Show content screen
            showPopup(getStateRendererType(), getMessage(),
                retryActionFunction: retryActionFunction ?? () {});
            return contentScreenWidget;
          } else {
            // full screen popup state
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction ?? () {});
          }
        }

      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      case ContentState:
        {
          dismissDialog();
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog();
          return contentScreenWidget;
        }
    }
  }

  void showPopup(StateRendererType stateRendererType, String message,
      {Function? retryActionFunction}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "",
          backgroundColor: getBackgroundColor() ?? ColorManager.transparent,
          content: StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryActionFunction: retryActionFunction ?? () {}));
    });
  }

  dismissDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
