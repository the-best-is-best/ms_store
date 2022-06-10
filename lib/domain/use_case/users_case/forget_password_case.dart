import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/users_requests.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class ForgetPasswordCase implements BaseCase<ForgetPasswordInput, bool> {
  final Repository _repository;
  ForgetPasswordCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(ForgetPasswordInput input) async {
    return await _repository
        .forgetPassword(ForgetPasswordRequests(input.email));
  }
}

class ForgetPasswordInput {
  final String email;

  ForgetPasswordInput(this.email);
}
