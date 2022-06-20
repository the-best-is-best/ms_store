import 'dart:developer';

import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/base_favorite_controller.dart';

import '../../../../../core/resources/strings_manager.dart';
import '../../../../../data/data_src/local_data_source.dart';
import '../../../../../domain/use_case/store/add_favorite_use_case.dart';
import '../../../../../domain/use_case/store/get_products_by_ids.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class FavController extends GetxController
    with BaseController, BaseFavoriteController {
  final AddFavoriteUseCase _addFavoriteUseCase;
  final GetProductByIdUseCase _getProductsFavoriteUseCase;

  final LocalDataSource _localDataSource;

  FavController(this._addFavoriteUseCase, this._localDataSource,
      this._getProductsFavoriteUseCase);
  RxMap<int, bool> favoriteModel = RxMap<int, bool>();
  RxList<ProductModel> productsInFav = RxList<ProductModel>();

  Future getProductsFavorite() async {
    Map<String, int> data = {};
    favoriteModel.forEach((k, _) {
      data.addAll({"id[${k - 1}]": k});
    });

    var result = await _getProductsFavoriteUseCase
        .execute(GetProductByIdUseCaseInput(data));
    result.fold((failure) => log(failure.messages),
        (data) => productsInFav.value = data);
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
