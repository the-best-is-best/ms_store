import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../../data/network/failure.dart';
import '../../repository/paymob_repository.dart';

class PayMobGetFirstTokenUseCase
    extends BaseCase<PayMobGetFirstTokenUseCaseInput, String> {
  final PayMobRepository paymobRepository;

  PayMobGetFirstTokenUseCase(this.paymobRepository);

  @override
  Future<Either<Failure, String>> execute(
      PayMobGetFirstTokenUseCaseInput input) async {
    return await paymobRepository.getFirstToken(input.apiKey);
  }
}

class PayMobGetFirstTokenUseCaseInput {
  final String apiKey;

  PayMobGetFirstTokenUseCaseInput(this.apiKey);
}
