import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/data/network/failure.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/models/store/reviews_model.dart';
import 'package:ms_store/domain/use_case/store/review/get_review_use_case.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/favorite_functions.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/home/view_model/home_controller.dart';

import '../../../../app/components.dart';
import '../../../../core/resources/routes_manger.dart';
import '../../../../domain/use_case/store/get_products_supplier_use_case.dart';

class ProductDetailsController extends GetxController with BaseController {
  final GetProductSupplierUseCase _getProductSupplierUseCase;
  final GetReviewUseCase _getReviewUseCase;

  ProductDetailsController(
      this._getProductSupplierUseCase, this._getReviewUseCase);
  RxList<ProductModel> productSupplier = RxList<ProductModel>();
  RxList<ProductModel> currentProduct = RxList<ProductModel>();
  Rx<ReviewsModel?> reviewProduct = Rx<ReviewsModel?>(null);

  int currentIndex = 0;
  void setCurrentPage({ProductModel? nextProduct}) {
    if (nextProduct != null) {
      currentProduct.add(nextProduct);
      if (currentIndex == 1) {
        currentProduct.removeAt(0);
      }
      currentIndex = 1;
    } else {
      if (currentIndex == 0) {
        Get.back();
        WidgetsBinding.instance.scheduleFrameCallback((_) {
          HomeController homeController = Get.find();
          homeController.getHomeData();
        });
      } else {
        currentProduct.removeAt(currentIndex);
        currentIndex--;
      }
    }
    _getReviewUseCase
        .execute(GetReviewUseCaseInput(currentProduct[currentIndex].id));
  }

  void getData(int productCat) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _getProductSupplierUseCase
        .execute(GetProductSupplierUseCaseInput(productCat));

    await waitStateChanged(duration: 1000);

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      productSupplier.value = data;
      var result = await _getReviewUseCase
          .execute(GetReviewUseCaseInput(currentProduct[currentIndex].id));
      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
            message: failure.messages);
      }, (data) {
        reviewProduct.value = data;
      });
      flowState.value = ContentState();
    });
  }

  void addToFavorite(ProductModel product) async {
    UserDataController userDataController = Get.find();
    if (userDataController.userModel.value == null) {
      initLoginModel();
      Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
    } else {
      flowState.value = LoadingState(
          stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
          message: AppStrings.loading);
      var result = await instance<FavoriteFunctions>()
          .addToFavorite(userDataController.userModel.value!.id, product.id);

      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }, (data) async {
        await instance<FavoriteFunctions>().updateFavData(product);
        await waitStateChanged(duration: 900);

        flowState.value = ContentState();
      });
    }
  }
}
