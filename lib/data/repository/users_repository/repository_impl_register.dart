import 'package:dartz/dartz.dart';
import '../../network/requests/users_requests.dart';

import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';

class RepositoryImplRegister {
  static Future<Either<Failure, bool>> call(RemoteDataSrc remoteDataSrc,
      NetworkInfo networkInfo, RegisterRequests registerRequesters) async {
    if (await networkInfo.isConnected) {
      try {
        var response = await remoteDataSrc.register(registerRequesters);
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
