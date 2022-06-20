import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/use_case/store/add_favorite_use_case.dart';
import 'package:ms_store/domain/use_case/store/get_favorite_use_case.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';

import '../../app/app_refs.dart';
import '../../data/network/failure.dart';
import '../../domain/models/users_model.dart';

mixin BaseFavoriteController {
  Future<Either<Failure, bool>> addToFavorite(
      AddFavoriteUseCase addFavoriteUseCase, int productId) async {
    UserModel? userModel = await AppPrefs().getUserData();

    return await addFavoriteUseCase
        .execute(AddFavoriteUseCaseInput(userModel!.id, productId));
  }

  Future<Either<Failure, Map<int, bool>>> getFavorite(
      GetFavoriteUseCase getFavoriteUseCase, int userId) async {
    return await getFavoriteUseCase.execute(GetFavoriteUseCaseInput(userId));
  }

  void updateFavData(FavController favController, ProductModel product) {
    if (favController.favoriteModel.containsKey(product.id)) {
      favController.favoriteModel[product.id] =
          !favController.favoriteModel[product.id]!;
      if (favController.favoriteModel[product.id] == true) {
        favController.productsInFav.add(product);
      } else {
        favController.productsInFav.remove(product);
      }
      favController.favoriteModel.refresh();
    } else {
      favController.favoriteModel.addAll({product.id: true});
      favController.productsInFav.add(product);
    }
    favController.saveFav();
  }
}
