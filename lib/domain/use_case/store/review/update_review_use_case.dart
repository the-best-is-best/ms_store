import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/store_requests.dart';
import 'package:ms_store/domain/repository/repository.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

class UpdateReviewUseCase extends BaseCase<UpdateReviewUseCaseInput, bool> {
  final Repository _repository;

  UpdateReviewUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(UpdateReviewUseCaseInput input) async {
    return await _repository.updateReview(UpdateReviewRequests(
        productId: input.productId,
        userId: input.userId,
        status: input.status,
        rating: input.rating,
        comment: input.comment));
  }
}

class UpdateReviewUseCaseInput {
  final int userId;
  final bool status;
  final int productId;
  final double rating;
  final String comment;

  UpdateReviewUseCaseInput(
      {required this.userId,
      required this.status,
      required this.productId,
      required this.rating,
      required this.comment});
}
