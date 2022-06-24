import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/get_product_review_response_mapper.dart';
import '../../../data_src/remote_data_src.dart';
import '../../../network/error_handler.dart';
import '../../../network/failure.dart';
import '../../../network/network_info.dart';
import '../../../network/requests/store_requests.dart';
import '../../../responses/store_responses/review/get_review_response.dart';
import '../../../responses/store_responses/review/update_review_response.dart';

class RepositoryImplUpdateReviewRequests {
  static Future<Either<Failure, bool>> call(
    RemoteDataSrc remoteDataSrc,
    NetworkInfo networkInfo,
    UpdateReviewRequests updateReviewRequests,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        UpdateReviewResponse response =
            await remoteDataSrc.updateReview(updateReviewRequests);

        if (response.statusCode! >= 200 && response.statusCode! <= 299) {
          //success
          // return either right
          // return data
          return const Right(true);
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
