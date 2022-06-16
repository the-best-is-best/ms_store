import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/categories_data_response_mapper.dart';
import '../../../domain/models/store/category_model.dart';
import '../../data_src/local_data_source.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../responses/store_responses/categories_responses.dart';

class RepositoryImplCategory {
  static Future<Either<Failure, CategoryModel>> call(
      RemoteDataSrc remoteDataSrc,
      NetworkInfo networkInfo,
      LocalDataSource _localDataSource) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await _localDataSource.getCategoryData();
        return Right(response);
      } catch (e) {
        print("error $e");

        try {
          CategoriesResponse response = await remoteDataSrc.getCategoryData();

          if (response.statusCode! >= 200 && response.statusCode! <= 299) {
            //success
            // return either right
            // return data
            _localDataSource.saveCategoryDataCache(response.toDomain());

            return Right(response.toDomain());
          } else {
            //failure
            // return either left
            return left(Failure(response.statusCode ?? 500, "Error server"));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
