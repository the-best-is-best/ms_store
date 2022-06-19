import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/repository/repository.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

// class GetProductByIds
//     extends BaseCase<GetProductsDetailsCartUseCaseInput, List<ProductModel>> {
//   final Repository _repository;

//   GetProductByIds(this._repository);
//   @override
//   Future<Either<Failure, List<ProductModel>>> execute(
//       GetProductsDetailsCartUseCaseInput input) async {
//     return await _repository
//         .getProductByIds(GetProductsDetailsCartUseCaseInput(input.id));
//   }
// }

// class GetProductsDetailsCartUseCaseInput {
//   final Map<String, dynamic> id;
//   GetProductsDetailsCartUseCaseInput(this.id);
// }
