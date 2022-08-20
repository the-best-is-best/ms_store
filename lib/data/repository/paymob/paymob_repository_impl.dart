import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/paymob/paymob_create_orders_requests.dart';
import 'package:ms_store/domain/repository/paymob_repository.dart';

import '../../data_src/remote_data_pay_mob_src.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';
import '../../network/network_info.dart';
import '../../responses/paymob/create_order_response.dart';
import '../../responses/paymob/get_first_token_response.dart';
import '../../responses/paymob/order_registration_response.dart';

class PayMobRepositoryImpl extends PayMobRepository {
  final RemoteDataPayMobSrc _dataPayMobSrc;
  final NetworkInfo _networkInfo;

  PayMobRepositoryImpl(this._dataPayMobSrc, this._networkInfo);
  @override
  Future<Either<Failure, String>> getFirstToken(String apiKey) async {
    if (await _networkInfo.isConnected) {
      try {
        GetFirstTokenResponse response =
            await _dataPayMobSrc.getFirstToken(apiKey);

        return Right(response.token);
      } catch (error) {
        return left(Failure(500, "Error server"));
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getOrderId(
      PayMobRequestCreateOrdersRequests createRequestOrdersRequests) async {
    if (await _networkInfo.isConnected) {
      try {
        OrderRegistrationResponse response =
            await _dataPayMobSrc.getOrderId(createRequestOrdersRequests);

        return Right(response.id);
      } catch (error) {
        return left(Failure(500, "Error server"));
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLastToken(
      PayMobCreateOrdersRequests createOrdersRequests) async {
    if (await _networkInfo.isConnected) {
      try {
        PayMobRequestCreateOrderResponse response =
            await _dataPayMobSrc.createOrdersRequests(createOrdersRequests);

        return Right(response.lastToken);
      } catch (error) {
        return left(Failure(500, "Error server"));
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, int>> buyRequest(BuyRequest bayRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        var response = await _dataPayMobSrc.buyRequest(bayRequest);

        return Right(response.id);
      } catch (error) {
        return left(Failure(500, "Error server"));
      }
    } else {
      //failure
      // return either left
      return Left(DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
