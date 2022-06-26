import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ms_store/domain/use_case/store/get_products_by_ids_use_case.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/components/products/functions.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';
import '../../../../../app/components.dart';
import '../../../../../app/di.dart';
import '../../../../../core/resources/routes_manger.dart';
import '../../../../../domain/models/home_models/home_data_model.dart';
import '../../../../../domain/use_case/home_use_case.dart';
import '../../../../../domain/use_case/store/get_category_data_by_id_use_case.dart';
import '../../../../base/user_data/user_data_controller.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../controller/main_view_controller.dart';

class HomeController extends GetxController with BaseController {
  final HomeUseCase _homeUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final GetCategoryDataByIdUseCase getCategoryDataByIdUseCase;

  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  HomeController(this._homeUseCase, this._getProductByIdUseCase,
      this.getCategoryDataByIdUseCase);

  Future getHomeData() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var resultHome = await _homeUseCase.execute(null);
    UserDataController userDataController = Get.find();
    if (userDataController.userModel.value == null) {
      await userDataController.getUserData();
    }
    await waitStateChanged();
    resultHome.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (homeObject) {
      homeModel.value = homeObject;
      if (homeModel.value == null) {
        flowState.value = EmptyState(message: AppStrings.noProducts);
      } else {
        flowState.value = ContentState();
      }
    });
  }

  void goCategory(int index) async {
    MainViewController mainViewController = Get.find();
    mainViewController.currentIndex.value = 1;
    CategoryController categoryController = Get.find();
    categoryController.selectedCategoryItem.value = index;
    categoryController.animateContainer.value = index;
  }

  void goProductByCat(int catId) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    var result = await getCategoryDataByIdUseCase
        .execute(GetCategoryDataByIdUseCaseInput(catId));
    await waitStateChanged();

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      flowState.value = ContentState();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initProductByCatId();
        Get.toNamed(Routes.productByCatIdRoute,
            arguments: {'categoryData': data});
      });
    });
  }

  // void addToFavoriteEvent(ProductModel product) async {
  //   UserDataController userDataController = Get.find();
  //   UserModel? userModel = userDataController.userModel.value;

  //   if (userModel != null) {
  //     flowState.value = LoadingState(
  //         stateRendererType: StateRendererType.POPUP_LOADING_STATE,
  //         message: AppStrings.loading);
  //     var result = await instance<FavoriteFunctions>()
  //         .addToFavorite(userDataController.userModel.value!.id, product.id);

  //     result.fold((failure) {
  //       flowState.value = ErrorState(
  //           stateRendererType: StateRendererType.POPUP_ERROR_STATE,
  //           message: failure.messages);
  //     }, (_) async {
  //       await instance<FavoriteFunctions>().updateFavData(product);
  //       await waitStateChanged();
  //       flowState.value = ContentState();
  //     });
  //   } else {
  //     initLoginModel();
  //     Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
  //   }
  // }

  void goProduct(int productId) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    Map<String, int> data = {"id[$productId]": productId};
    var result =
        await _getProductByIdUseCase.execute(GetProductByIdUseCaseInput(data));
    await waitStateChanged();

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      flowState.value = ContentState();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        goToProductDetails(data[0]);
      });
    });
  }
}
