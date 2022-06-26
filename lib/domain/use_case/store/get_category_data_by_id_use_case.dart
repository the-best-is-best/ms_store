import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/domain/repository/repository.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/requests/store_requests.dart';

class GetCategoryDataByIdUseCase
    extends BaseCase<GetCategoryDataByIdUseCaseInput, CategoryDataModel> {
  final Repository _repository;

  GetCategoryDataByIdUseCase(this._repository);
  @override
  Future<Either<Failure, CategoryDataModel>> execute(
      GetCategoryDataByIdUseCaseInput input) async {
    return await _repository
        .getCategoryDataById(GetCategoryDataByIdRequests(input.catId));
  }
}

class GetCategoryDataByIdUseCaseInput {
  final int catId;

  GetCategoryDataByIdUseCaseInput(this.catId);
}
