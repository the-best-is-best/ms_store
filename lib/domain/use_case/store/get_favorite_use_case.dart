import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/requests/favorites_requests.dart';
import '../../repository/repository.dart';

class GetFavoriteUseCase
    extends BaseCase<GetFavoriteUseCaseInput, Map<int, bool>> {
  final Repository _repository;

  GetFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, Map<int, bool>>> execute(
      GetFavoriteUseCaseInput input) async {
    return await _repository
        .getProductToFavorite(GetFavoriteRequests(input.userId));
  }
}

class GetFavoriteUseCaseInput {
  final int userId;
  GetFavoriteUseCaseInput(this.userId);
}
