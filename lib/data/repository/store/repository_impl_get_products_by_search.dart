import 'package:dartz/dartz.dart';
import 'package:ms_store/data/mapper/store/get_products_with_pagination_response_mapper.dart';
import 'package:ms_store/data/network/requests/store_requests.dart';
import 'package:ms_store/domain/models/store/product_with_pagination_model.dart';
import '../../data_src/remote_data_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../responses/store_responses/get_products_with_pagination_response.dart';
import '../../mapper/store/get_products_with_pagination_response_mapper.dart';

class RepositoryImplGetProductsBySearch {
  static Future<Either<Failure, ProductWithPaginationModel>> call(
    RemoteDataSrc remoteDataSrc,
    NetworkInfo networkInfo,
    GetProductsBySearchRequests getProductsBySearchRequests,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        ProductWithPaginationDataResponse response = await remoteDataSrc
            .getProductsBySearch(getProductsBySearchRequests);

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
