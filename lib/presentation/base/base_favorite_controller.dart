import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/use_case/store/add_favorite_use_case.dart';
import 'package:ms_store/domain/use_case/store/get_favorite_use_case.dart';

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
}
