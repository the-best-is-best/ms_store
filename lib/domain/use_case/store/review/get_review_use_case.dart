// ignore_for_file: unused_field

import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/store/reviews_model.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../../data/network/requests/store_requests.dart';
import '../../../repository/repository.dart';

class GetReviewUseCase extends BaseCase<GetReviewUseCaseInput, ReviewsModel> {
  final Repository _repository;

  GetReviewUseCase(this._repository);

  @override
  Future<Either<Failure, ReviewsModel>> execute(
      GetReviewUseCaseInput input) async {
    return await _repository.getReview(GetReviewRequests(input.productId));
  }
}

class GetReviewUseCaseInput {
  final int productId;

  GetReviewUseCaseInput(this.productId);
}
