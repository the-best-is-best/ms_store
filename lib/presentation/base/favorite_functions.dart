import 'package:dartz/dartz.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/domain/use_case/store/add_favorite_use_case.dart';
import 'package:ms_store/domain/use_case/store/get_favorite_use_case.dart';
import '../../data/network/failure.dart';

class FavoriteFunctions {
  Future<Either<Failure, bool>> addToFavorite(int userId, int productId) async {
    return await instance<AddFavoriteUseCase>()
        .execute(AddFavoriteUseCaseInput(userId, productId));
  }

  Future<Either<Failure, Map<int, bool>>> getFavorite(
      GetFavoriteUseCase getFavoriteUseCase, int userId) async {
    return await getFavoriteUseCase.execute(GetFavoriteUseCaseInput(userId));
  }
}
