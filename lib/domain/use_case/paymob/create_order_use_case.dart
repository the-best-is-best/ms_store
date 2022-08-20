import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/paymob/paymob_create_orders_requests.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/failure.dart';
import '../../repository/paymob_repository.dart';

class PayMobCreateOrderUseCase
    extends BaseCase<PayMobCreateOrderUseCaseInput, String> {
  PayMobCreateOrderUseCase(this.paymobRepository);

  final PayMobRepository paymobRepository;

  @override
  Future<Either<Failure, String>> execute(
      PayMobCreateOrderUseCaseInput input) async {
    return await paymobRepository.getLastToken(PayMobCreateOrdersRequests(
        authToken: input.authToken,
        amountCents: input.amountCents,
        billingData: input.billingData,
        currency: input.currency,
        orderId: input.orderId,
        integrationId: input.integrationId));
  }
}

class PayMobCreateOrderUseCaseInput {
  final String authToken;
  final int orderId;
  final int integrationId;
  final int amountCents;
  final String currency;
  final Map<String, String> billingData;

  PayMobCreateOrderUseCaseInput({
    required this.authToken,
    required this.amountCents,
    required this.integrationId,
    this.currency = "EGP",
    required this.billingData,
    required this.orderId,
  });
}
