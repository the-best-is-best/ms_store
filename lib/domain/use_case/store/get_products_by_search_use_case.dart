import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/failure.dart';
import 'package:ms_store/domain/use_case/use_case.dart';
import '../../../data/network/requests/store_requests.dart';
import '../../models/store/product_with_pagination_model.dart';
import '../../repository/repository.dart';

class GetProductsBySearchUseCase extends BaseCase<
    GetProductsBySearchUseCaseInput, ProductWithPaginationModel> {
  final Repository _repository;

  GetProductsBySearchUseCase(this._repository);

  @override
  Future<Either<Failure, ProductWithPaginationModel>> execute(
      GetProductsBySearchUseCaseInput input) async {
    return await _repository
        .getProductBySearch(GetProductsBySearchRequests(input.name));
  }
}

class GetProductsBySearchUseCaseInput {
  final String name;

  GetProductsBySearchUseCaseInput(this.name);
}
