import 'package:get/get.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/base_favorite_controller.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';
import '../../../../../app/components.dart';
import '../../../../../app/di.dart';
import '../../../../../core/resources/routes_manger.dart';
import '../../../../../domain/models/home_models/home_data_model.dart';
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
    if (userDataController.userModel.value == null) {
      await userDataController.getUserData();
    }
    await waitStateChanged(duration: 1000);
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
    UserDataController userDataController = Get.find();
    UserModel? userModel = userDataController.userModel.value;
    FavController favController = Get.find();

    if (userModel != null) {
      flowState.value = LoadingState(
          stateRendererType: StateRendererType.POPUP_LOADING_STATE,
          message: AppStrings.loading);
      var result = await addToFavorite(_addFavoriteUseCase, productId);

      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }, (_) async {
        if (favController.favoriteModel.containsKey(productId)) {
          favController.favoriteModel[productId] =
              !favController.favoriteModel[productId]!;
        } else {
          if (favController.favoriteModel.containsKey([productId])) {
            favController.favoriteModel[productId] =
                !favController.favoriteModel[productId]!;
          } else {
            favController.favoriteModel.addAll({productId: true});
          }
          favController.saveFav();
        }
        await favController.saveFav();
      });
      await waitStateChanged(duration: 900);
      flowState.value = ContentState();
    } else {
      initLoginModel();
      Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
    }
  }
}
