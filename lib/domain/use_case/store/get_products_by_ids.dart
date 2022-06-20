import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/repository/repository.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/requests/store_requests.dart';

class GetProductByIdUseCase
    extends BaseCase<GetProductByIdUseCaseInput, List<ProductModel>> {
  final Repository _repository;

  GetProductByIdUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductModel>>> execute(
      GetProductByIdUseCaseInput input) async {
    return await _repository
        .getProductByIds(GetProductByIdsRequests(input.ids));
  }
}

class GetProductByIdUseCaseInput {
  final Map<String, int> ids;

  GetProductByIdUseCaseInput(this.ids);
}
