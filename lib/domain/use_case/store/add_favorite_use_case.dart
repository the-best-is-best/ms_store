import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/requests/store_requests.dart';
import '../../repository/repository.dart';

class AddFavoriteUseCase extends BaseCase<AddFavoriteUseCaseInput, bool> {
  final Repository _repository;

  AddFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(AddFavoriteUseCaseInput input) async {
    return await _repository.addProductToFavorite(
        AddFavoriteRequests(userId: input.userId, productId: input.productId));
  }
}

class AddFavoriteUseCaseInput {
  final int userId;
  final int productId;

  AddFavoriteUseCaseInput(this.userId, this.productId);
}
