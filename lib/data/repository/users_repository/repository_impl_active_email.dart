import 'package:dartz/dartz.dart';

import '../../../../domain/models/users_model.dart';
import '../../data_src/remote_data_src.dart';
import '../../mapper/users_response_mapper.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../network/requests/users_requests.dart';

class RepositoryImplActiveEmail {
  static Future<Either<Failure, UserModel>> call(RemoteDataSrc remoteDataSrc,
      NetworkInfo networkInfo, ActiveEmailRequests activeEmailRequests) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteDataSrc.activeEmail(activeEmailRequests);
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
