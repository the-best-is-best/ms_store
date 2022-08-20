import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/paymob/paymob_create_orders_requests.dart';

import '../../data/network/failure.dart';

abstract class PayMobRepository {
  Future<Either<Failure, String>> getFirstToken(String apiKey);
  Future<Either<Failure, int>> getOrderId(
      PayMobCreateOrdersRequests createOrdersRequests);
}
