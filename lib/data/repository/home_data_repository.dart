import 'package:dartz/dartz.dart';

import '../../domain/models/home_models/home_data_model.dart';
import '../data_src/local_data_source.dart';
import '../data_src/remote_data_src.dart';
import '../mapper/store/home/home_data_response_mapper.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpGetHomeData {
  static Future<Either<Failure, HomeModel>> call(RemoteDataSrc remoteDataSrc,
      NetworkInfo networkInfo, LocalDataSource _localDataSource) async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response);
    } catch (cacheError) {
      if (await networkInfo.isConnected) {
        try {
          var response = await remoteDataSrc.getHomeData();
          if (response.statusCode! >= 200 && response.statusCode! <= 299) {
            //success
            // return either right
            // return data
            _localDataSource.saveHomeDataCache(response.toDomain());
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
}
