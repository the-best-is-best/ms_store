import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/requests/store_requests.dart';
import '../../repository/repository.dart';

class GetProductSupplierUseCase
    extends BaseCase<GetProductSupplierUseCaseInput, List<ProductModel>> {
  final Repository _repository;

  GetProductSupplierUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductModel>>> execute(
      GetProductSupplierUseCaseInput input) async {
    return await _repository
        .getProductsSupplier(GetProductsSupplierRequests(input.categoryId));
  }
}

class GetProductSupplierUseCaseInput {
  final int categoryId;

  GetProductSupplierUseCaseInput(this.categoryId);
}
