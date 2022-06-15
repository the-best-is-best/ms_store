import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/cache/cache_server.dart';

import '../../../domain/models/cache/cache_data.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';

class RepositoryImplCacheDataServer {
  static Future<Either<Failure, CheckCachedDataServer>> call(
      RemoteDataSrc remoteDataSrc, NetworkInfo networkInfo) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteDataSrc.getCache();
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
