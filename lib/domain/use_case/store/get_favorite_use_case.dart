import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/requests/favorites_requests.dart';
import '../../repository/repository.dart';

class GetFavoriteUseCase
    extends BaseCase<GetFavoriteUseCaseInput, FavoriteModel> {
  final Repository _repository;

  GetFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, FavoriteModel>> execute(
      GetFavoriteUseCaseInput input) async {
    return await _repository
        .getProductToFavorite(GetFavoriteRequests(input.userId));
  }
}

class GetFavoriteUseCaseInput {
  final int userId;
  GetFavoriteUseCaseInput(this.userId);
}
