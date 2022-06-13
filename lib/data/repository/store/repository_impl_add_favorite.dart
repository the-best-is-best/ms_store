import 'package:dartz/dartz.dart';
import 'package:ms_store/data/responses/store_responses/favorite_add_response.dart';

import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../network/requests/favorites_requests.dart';

class RepositoryImplAddFavorite {
  static Future<Either<Failure, bool>> call(RemoteDataSrc remoteDataSrc,
      NetworkInfo networkInfo, AddFavoriteRequests addFavoriteRequests) async {
    if (await networkInfo.isConnected) {
      try {
        FavoriteAddResponse response =
            await remoteDataSrc.favoriteAdd(addFavoriteRequests);

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
