import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/users_requests.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class ResetPasswordCase
    implements BaseCase<ResetPasswordCasePasswordInput, bool> {
  final Repository _repository;
  ResetPasswordCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(
      ResetPasswordCasePasswordInput input) async {
    return await _repository.resetPassword(ResetPasswordRequests(
        email: input.email, pin: input.pin, password: input.password));
  }
}

class ResetPasswordCasePasswordInput {
  final String pin;
  final String password;
  final String email;

  ResetPasswordCasePasswordInput(
      {required this.pin, required this.password, required this.email});
}
