import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import '../../../../../app/components.dart';
import '../../../../../app/di.dart';
import '../../../../../app/resources/routes_manger.dart';
import '../../../../../data/data_src/local_data_source.dart';
import '../../../../../data/network/failure.dart';
import '../../../../../domain/use_case/store/add_favorite_use_case.dart';
import '../../../../../domain/use_case/store/get_favorite_use_case.dart';
import '../../../../../domain/use_case/store/get_products_by_ids_use_case.dart';
import '../../../../base/user_data/user_data_controller.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class FavController extends GetxController with BaseController {
  final GetProductByIdUseCase _getProductsFavoriteUseCase;

  final LocalDataSource _localDataSource;

  FavController(this._localDataSource, this._getProductsFavoriteUseCase);
  RxMap<int, bool> favoriteModel = RxMap<int, bool>();
  RxList<ProductModel> productsInFav = RxList<ProductModel>();

  Future getProductsFavorite(Map<int, bool> favoriteData) async {
    if (favoriteData.isNotEmpty) {
      Map<String, int> data = {};
      favoriteModel.forEach((k, _) {
        data.addAll({"id[$k]": k});
      });

      var result = await _getProductsFavoriteUseCase
          .execute(GetProductByIdUseCaseInput(data));
      result.fold((failure) => log(failure.messages),
          (data) => productsInFav.value = data);
      printInfo(info: productsInFav.length.toString());
    }
  }

  Rx<int?> productId = Rx<int?>(null);
  Future addToFavoriteEvent(ProductModel product) async {
    UserDataController userDataController = Get.find();
    if (userDataController.userModel.value == null) {
      initLoginModel();
      Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
    } else {
      productId.value = product.id;

      var result = await addToFavorite(
          userDataController.userModel.value!.id, product.id);
      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }, (data) async {
        await updateFavData(product);
        await waitStateChanged();
        productId.value = null;
        favoriteModel.refresh();
        flowState.value = ContentState();
      });
    }
  }

  Future updateFavData(ProductModel product) async {
    FavController favController = Get.find();
    if (favController.favoriteModel.containsKey(product.id)) {
      if (favController.favoriteModel[product.id] == true) {
        favController.productsInFav.remove(product);
        favController.favoriteModel[product.id] = false;
      } else {
        favController.productsInFav.add(product);
        favController.favoriteModel[product.id] = true;
      }
      favController.favoriteModel.refresh();
    } else {
      favController.favoriteModel.addAll({product.id: true});
      favController.productsInFav.add(product);
    }
    await favController.saveFav();
  }

  Future saveFav() async {
    await _localDataSource.saveFavoriteDataCache(favoriteModel);
    await _localDataSource.saveProductFavData(productsInFav);
  }

  Future<Either<Failure, bool>> addToFavorite(int userId, int productId) async {
    return await instance<AddFavoriteUseCase>()
        .execute(AddFavoriteUseCaseInput(userId, productId));
  }

  Future<Either<Failure, Map<int, bool>>> getFavorite(
      GetFavoriteUseCase getFavoriteUseCase, int userId) async {
    return await getFavoriteUseCase.execute(GetFavoriteUseCaseInput(userId));
  }

  void clearData() {
    favoriteModel.value = {};
    productsInFav.value = [];
  }
}
