import 'dart:developer';

import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:ms_store/presentation/base/favorite_functions.dart';

import '../../../../../app/components.dart';
import '../../../../../app/di.dart';
import '../../../../../core/resources/routes_manger.dart';
import '../../../../../data/data_src/local_data_source.dart';
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

  Future getProductsFavorite() async {
    if (favoriteModel.isNotEmpty) {
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

      var result = await instance<FavoriteFunctions>()
          .addToFavorite(userDataController.userModel.value!.id, product.id);
      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }, (data) async {
        await updateFavData(product);
        await waitStateChanged();
        productId.value = null;

        flowState.value = ContentState();
      });
    }
  }

  Future updateFavData(ProductModel product) async {
    FavController favController = Get.find();
    if (favController.favoriteModel.containsKey(product.id)) {
      if (favController.favoriteModel[product.id] == true) {
        favController.productsInFav.remove(product);
      } else {
        favController.productsInFav.add(product);
      }
      favController.favoriteModel[product.id] =
          favController.favoriteModel[product.id] == true ? false : true;
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
}
