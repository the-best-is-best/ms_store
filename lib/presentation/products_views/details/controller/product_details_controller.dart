import 'package:get/get.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/models/store/reviews_model.dart';
import 'package:ms_store/domain/use_case/store/review/get_review_use_case.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../../../app/components.dart';
import '../../../../app/resources/routes_manger.dart';
import '../../../../domain/use_case/store/get_products_supplier_use_case.dart';
import '../../../../domain/use_case/store/review/update_review_use_case.dart';
import '../../../common/freezed/freezed_data.dart';

class ProductDetailsController extends GetxController with BaseController {
  final GetProductSupplierUseCase _getProductSupplierUseCase;
  final GetReviewUseCase _getReviewUseCase;
  final UpdateReviewUseCase _updateReviewUseCase;

  ProductDetailsController(this._getProductSupplierUseCase,
      this._getReviewUseCase, this._updateReviewUseCase);
  RxList<ProductModel> productSupplier = RxList<ProductModel>();
  RxList<ProductModel> currentProduct = RxList<ProductModel>();
  Rx<ReviewsModel?> reviewProduct = Rx<ReviewsModel?>(null);
  Rx<ReviewsProductModel?> userReview = Rx<ReviewsProductModel?>(null);
  int currentIndex = 0;
  void setCurrentPage({ProductModel? nextProduct}) async {
    if (nextProduct != null) {
      currentProduct.add(nextProduct);
      if (currentIndex == 1) {
        currentProduct.removeAt(0);
      }
      currentIndex = 1;
    } else {
      if (currentIndex == 0) {
        Get.back();
      } else {
        currentProduct.removeAt(currentIndex);
        currentIndex--;
      }
    }
    reviewObject.value =
        reviewObject.value.copyWith(productId: currentProduct[currentIndex].id);
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _getReviewUseCase
        .execute(GetReviewUseCaseInput(currentProduct[currentIndex].id));
    await waitStateChanged();

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (data) {
      reviewProduct.value = data;
      UserDataController userDataController = Get.find();
      if (userDataController.userModel.value != null) {
        userReview.value = reviewProduct.value?.dataReview.firstWhereOrNull(
            (element) =>
                element.userId == userDataController.userModel.value!.id);
      }
    });
    flowState.value = ContentState();
  }

  void getData(int productCat) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _getProductSupplierUseCase
        .execute(GetProductSupplierUseCaseInput(productCat));
    await waitStateChanged();

    reviewObject.value =
        reviewObject.value.copyWith(productId: currentProduct[currentIndex].id);

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      productSupplier.value = data;
      var result = await _getReviewUseCase
          .execute(GetReviewUseCaseInput(currentProduct[currentIndex].id));
      await waitStateChanged();

      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
            message: failure.messages);
      }, (data) {
        reviewProduct.value = data;
        UserDataController userDataController = Get.find();
        if (userDataController.userModel.value != null) {
          userReview.value =
              reviewProduct.value?.dataReview.firstWhereOrNull((element) {
            return element.userId == userDataController.userModel.value!.id;
          });
        }
      });
      flowState.value = ContentState();
    });
  }

  Rx<ReviewObject> reviewObject = ReviewObject(0, false, 0, 0, "").obs;
  void addRating(double rate) {
    reviewObject.value = reviewObject.value.copyWith(rating: rate);
  }

  void addComment(String comment) {
    reviewObject.value = reviewObject.value.copyWith(comment: comment);
    if (comment.isEmpty) {
      reviewObject.value = reviewObject.value.copyWith(status: false);
    } else {
      reviewObject.value = reviewObject.value.copyWith(status: true);
    }
  }

  void updateReview() async {
    UserDataController userDataController = Get.find();
    if (userDataController.userModel.value == null) {
      initLoginModel();
      Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
    } else {
      ReviewObject reviewObjectData = reviewObject.value;
      reviewObjectData = reviewObjectData.copyWith(
          userId: userDataController.userModel.value!.id);
      await waitStateChanged();

      flowState.value = LoadingState(
          stateRendererType: StateRendererType.POPUP_LOADING_STATE,
          message: AppStrings.loading);
      var result = await _updateReviewUseCase.execute(UpdateReviewUseCaseInput(
          userId: reviewObjectData.userId,
          status: reviewObjectData.status,
          rating: reviewObjectData.rating,
          productId: reviewObjectData.productId,
          comment: reviewObjectData.comment));
      await waitStateChanged();

      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }, (data) async {
        await waitStateChanged();
        var result = await _getReviewUseCase
            .execute(GetReviewUseCaseInput(currentProduct[currentIndex].id));
        await waitStateChanged();

        result.fold((failure) {
          flowState.value = ErrorState(
              stateRendererType: StateRendererType.POPUP_ERROR_STATE,
              message: failure.messages);
        }, (data) {
          reviewProduct.value = data;
          UserDataController userDataController = Get.find();
          if (userDataController.userModel.value != null) {
            userReview.value = reviewProduct.value?.dataReview.firstWhereOrNull(
                (element) =>
                    element.userId == userDataController.userModel.value!.id);
          }
        });
        flowState.value = ContentState();
      });
    }
  }
}
