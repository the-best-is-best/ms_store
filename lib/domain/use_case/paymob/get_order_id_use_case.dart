import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/paymob/paymob_create_orders_requests.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/failure.dart';
import '../../repository/paymob_repository.dart';

class PayMobGetOrderIdUseCase
    extends BaseCase<PayMobGetOrderIdUseCaseInput, int> {
  PayMobGetOrderIdUseCase(this.paymobRepository);

  final PayMobRepository paymobRepository;

  @override
  Future<Either<Failure, int>> execute(
      PayMobGetOrderIdUseCaseInput input) async {
    return await paymobRepository.getOrderId(PayMobCreateOrdersRequests(
        authToken: input.authToken,
        amountCents: input.amountCents,
        items: input.items));
  }
}

class PayMobGetOrderIdUseCaseInput {
  final String authToken;
  final int amountCents;
  final String? currency;
  final String? deliveryNeeded;
  final List<Map<String, dynamic>>? items;

  PayMobGetOrderIdUseCaseInput(
      {required this.authToken,
      required this.amountCents,
      this.currency,
      this.deliveryNeeded,
      this.items});
}
