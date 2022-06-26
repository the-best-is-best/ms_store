import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/get_category_data_by_id_response_mapper.dart';

import '../../../domain/models/store/category_model.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../network/requests/store_requests.dart';
import '../../responses/store_responses/get_category_data_by_id.dart';

class RepositoryImplGetCategoryDataById {
  static Future<Either<Failure, CategoryDataModel>> call(
    RemoteDataSrc remoteDataSrc,
    NetworkInfo networkInfo,
    GetCategoryDataByIdRequests getCategoryDataByIdRequests,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        GetCategoryDataByIdResponse response = await remoteDataSrc
            .getCategoryDataById(getCategoryDataByIdRequests);

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
