import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:ms_store/data/network/error_handler.dart';
import 'package:ms_store/domain/use_case/store/add_favorite_use_case.dart';
import 'package:ms_store/domain/use_case/store/get_favorite_use_case.dart';

import '../../app/app_refs.dart';
import '../../app/di.dart';
import '../../core/resources/routes_manger.dart';
import '../../data/network/failure.dart';
import '../../domain/models/users_model.dart';

mixin BaseFavoriteController {
  Future<Either<Failure, bool>> addToFavorite(
      AddFavoriteUseCase addFavoriteUseCase, int productId) async {
    UserModel? userModel = await AppPrefs().getUserData();
    if (userModel == null) {
      initLoginModel();
      Get.toNamed(Routes.loginRoute, arguments: {'canBack': true});
    } else {
      return await addFavoriteUseCase
          .execute(AddFavoriteUseCaseInput(userModel.id, productId));
    }
    return Left(DataRes.DEFAULT.getFailure());
  }

  Future<Either<Failure, Map<int, bool>>> getFavorite(
      GetFavoriteUseCase getFavoriteUseCase, int userId) async {
    return await getFavoriteUseCase.execute(GetFavoriteUseCaseInput(userId));
  }
}
