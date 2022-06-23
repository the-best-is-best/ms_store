import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/get_product_review_response_mapper.dart';

import '../../../domain/models/store/reviews_model.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../network/requests/store_requests.dart';
import '../../responses/store_responses/review/get_review_response.dart';

class RepositoryImplGetReviewRequests {
  static Future<Either<Failure, ReviewsModel>> call(
    RemoteDataSrc remoteDataSrc,
    NetworkInfo networkInfo,
    GetReviewRequests getReviewRequests,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        GetReviewsDataModelResponse response =
            await remoteDataSrc.getReview(getReviewRequests);

        if (response.statusCode! >= 200 && response.statusCode! <= 299) {
          //success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          //failure
          // return either left
          return left(Failure(response.statusCode ?? 500, "Error server"));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
