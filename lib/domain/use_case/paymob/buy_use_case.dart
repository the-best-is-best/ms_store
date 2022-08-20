import 'package:dartz/dartz.dart';
import 'package:ms_store/data/network/requests/paymob/paymob_create_orders_requests.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/failure.dart';
import '../../repository/paymob_repository.dart';

class BuyUseCase extends BaseCase<BuyUseCaseUseCasInput, int> {
  BuyUseCase(this.paymobRepository);

  final PayMobRepository paymobRepository;

  @override
  Future<Either<Failure, int>> execute(BuyUseCaseUseCasInput input) async {
    return await paymobRepository.buyRequest(
        BuyRequest(authToken: input.authToken, source: input.source));
  }
}

class BuyUseCaseUseCasInput {
  final String authToken;
  final Map<String, String> source;

  BuyUseCaseUseCasInput({
    required this.authToken,
    required this.source,
  });
}
