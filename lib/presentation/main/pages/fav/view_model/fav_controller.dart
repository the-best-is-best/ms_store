import 'package:get/get.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/core/resources/routes_manger.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/base_favorite_controller.dart';

import '../../../../../app/app_refs.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../data/data_src/local_data_source.dart';
import '../../../../../domain/models/users_model.dart';
import '../../../../../domain/use_case/store/add_favorite_use_case.dart';
import '../../../../../domain/use_case/store/get_favorite_use_case.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class FavController extends GetxController
    with BaseController, BaseFavoriteController {
  final AddFavoriteUseCase _addFavoriteUseCase;
  final GetFavoriteUseCase _getFavoriteUseCase;
  final LocalDataSource _localDataSource;

  FavController(this._addFavoriteUseCase, this._getFavoriteUseCase,
      this._localDataSource);
  RxMap<int, FavoriteDataModel> favoriteModel = RxMap<int, FavoriteDataModel>();

  Future addToFavoriteEvent(int productId) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);

    var result = await addToFavorite(_addFavoriteUseCase, productId);
    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: failure.messages);
    }, (data) {
      if (favoriteModel.containsKey([productId])) {
        favoriteModel[productId]!.status = !favoriteModel[productId]!.status;
      } else {
        favoriteModel.addAll({productId: FavoriteDataModel(productId, true)});
      }
      saveFav();
      flowState.value = ContentState();
    });
  }

  Future getFavoriteEvent() async {
    UserModel? userModel = await AppPrefs().getUserData();
    if (userModel == null) {
      initLoginModel();
      Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
    } else {
      var result = await _getFavoriteUseCase
          .execute(GetFavoriteUseCaseInput(userModel.id));
      result.fold((failure) {
        print(failure);
      }, (data) async {
        print(data.keys);
        data.forEach((key, value) {
          if (key == 4) {
            print("Product data ${value.status}");
          }
          favoriteModel[key] = value;
        });

        await saveFav();
        flowState.value = ContentState();
      });
    }
  }

  Future saveFav() async {
    await _localDataSource.saveFavoriteDataCache(favoriteModel);
  }
}
