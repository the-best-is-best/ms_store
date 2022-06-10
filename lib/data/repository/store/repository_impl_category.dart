import 'package:dartz/dartz.dart';
import '../../mapper/store/category_response_mapper.dart';

import '../../../domain/models/store/category_model.dart';

import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../responses/store_responses/categories_responses.dart';

class RepositoryImplCategory {
  static Future<Either<Failure, List<CategoryModel>>> call(
      RemoteDataSrc remoteDataSrc, NetworkInfo networkInfo) async {
    if (await networkInfo.isConnected) {
      try {
        CategoriesResponse response = await remoteDataSrc.getCategoryData();
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