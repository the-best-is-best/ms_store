import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/store_requests.dart';
import 'package:ms_store/domain/models/store/product_with_pagination_model.dart';
import 'package:ms_store/domain/repository/repository.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

class GetProductByCatIdUseCase extends BaseCase<GetProductByCatIdUseCaseInput,
    ProductWithPaginationModel> {
  final Repository _repository;

  GetProductByCatIdUseCase(this._repository);
  @override
  Future<Either<Failure, ProductWithPaginationModel>> execute(
      GetProductByCatIdUseCaseInput input) async {
    return await _repository.getProductsByCatId(GetProductsByCatIdRequests(
        input.catId, input.currentPage, input.minPrice, input.maxPrice));
  }
}

class GetProductByCatIdUseCaseInput {
  final int catId;
  final int currentPage;
  final num? minPrice;
  final num? maxPrice;
  GetProductByCatIdUseCaseInput(this.catId,
      {required this.currentPage, this.minPrice, this.maxPrice});
}
