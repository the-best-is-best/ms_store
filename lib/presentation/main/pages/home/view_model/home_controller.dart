import 'package:get/get.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/data/data_src/local_data_source.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/base_favorite_controller.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';

import '../../../../../app/app_refs.dart';
import '../../../../../app/components.dart';
import '../../../../../core/resources/routes_manger.dart';
import '../../../../../domain/models/home_models/home_data_model.dart';
import '../../../../../domain/models/store/favorite_model.dart';
import '../../../../../domain/models/users_model.dart';
import '../../../../../domain/use_case/home_use_case.dart';
import '../../../../../domain/use_case/store/add_favorite_use_case.dart';
import '../../../../base/user_data/user_data_controller.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../controller/main_view_controller.dart';
import '../../fav/view_model/fav_controller.dart';

class HomeController extends GetxController
    with BaseController, BaseFavoriteController {
  final HomeUseCase _homeUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;

  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  HomeController(this._homeUseCase, this._addFavoriteUseCase);

  Future getHomeData() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var resultHome = await _homeUseCase.execute(null);
    UserDataController userDataController = Get.find();
    await userDataController.getUserData();
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

  void addToFavoriteEvent(int productId) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    var result = await addToFavorite(_addFavoriteUseCase, productId);
    await waitStateChanged(duration: 1000);

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: failure.messages);
    }, (_) async {
      UserDataController userDataController = Get.find();
      UserModel? userModel = userDataController.userModel.value;
      FavController favController = Get.find();

      if (userModel != null) {
        if (favController.favoriteModel.containsKey(productId)) {
          favController.favoriteModel[productId]!.status =
              !favController.favoriteModel[productId]!.status;
        } else {
          if (favController.favoriteModel.containsKey([productId])) {
            favController.favoriteModel[productId]!.status =
                !favController.favoriteModel[productId]!.status;
          } else {
            favController.favoriteModel
                .addAll({productId: FavoriteDataModel(productId, true)});
          }
          favController.saveFav();
        }
        await favController.saveFav();
      }
      await waitStateChanged(duration: 900);
      flowState.value = ContentState();
    });
  }
}
