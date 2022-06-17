import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/favorite_response_mapper.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';

import '../../data_src/local_data_source.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../network/requests/favorites_requests.dart';

class RepositoryImplGetFavorite {
  static Future<Either<Failure, Map<int, FavoriteDataModel>>> call(
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
            Map<int, FavoriteDataModel> data = {};
            if (response.data != null) {
              for (var productFav in response.data!) {
                data[productFav.toDomain().productId] = productFav.toDomain();
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
