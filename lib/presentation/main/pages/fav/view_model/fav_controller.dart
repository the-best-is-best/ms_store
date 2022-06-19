import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/base_favorite_controller.dart';

import '../../../../../core/resources/strings_manager.dart';
import '../../../../../data/data_src/local_data_source.dart';
import '../../../../../domain/use_case/store/add_favorite_use_case.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class FavController extends GetxController
    with BaseController, BaseFavoriteController {
  final AddFavoriteUseCase _addFavoriteUseCase;
  final LocalDataSource _localDataSource;

  FavController(this._addFavoriteUseCase, this._localDataSource);
  RxMap<int, bool> favoriteModel = RxMap<int, bool>();
  RxList<ProductModel> productsInFav = RxList<ProductModel>();
  @override
  void onInit() async {
    try {
      productsInFav.value = await _localDataSource.getProductFavData();
    } catch (_) {}
    super.onInit();
  }

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
        favoriteModel[productId] = !favoriteModel[productId]!;
      } else {
        favoriteModel.addAll({productId: true});
      }
      saveFav();
      flowState.value = ContentState();
    });
  }

  Future saveFav() async {
    await _localDataSource.saveFavoriteDataCache(favoriteModel);
  }
}
