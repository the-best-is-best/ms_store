import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/favorite_response_mapper.dart';
import '../../data_src/local_data_source.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../network/requests/store_requests.dart';

class RepositoryImplGetFavorite {
  static Future<Either<Failure, Map<int, bool>>> call(
      RemoteDataSrc remoteDataSrc,
      NetworkInfo networkInfo,
      LocalDataSource _localDataSource,
      GetFavoriteRequests getFavoriteRequests) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await _localDataSource.getFavoriteData();
        return Right(response);
      } catch (cacheError) {
        try {
          var response = await remoteDataSrc
              .getFavorite(GetFavoriteRequests(getFavoriteRequests.userId));
          if (response.statusCode! >= 200 && response.statusCode! <= 299) {
            //success
            // return either right
            // return data
            Map<int, bool> data = {};
            if (response.data != null) {
              for (var productFav in response.data!) {
                data[productFav.toDomain().productId] =
                    (productFav.toDomain()).status;
              }
            }

            _localDataSource.saveFavoriteDataCache(data);
            return Right(data);
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
