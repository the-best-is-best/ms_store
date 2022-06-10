import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/users_requests.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class RegisterUserCase implements BaseCase<RegisterUserCaseInput, bool> {
  final Repository _repository;

  RegisterUserCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(RegisterUserCaseInput input) async {
    return await _repository.register(RegisterRequests(
        email: input.email,
        password: input.password,
        userName: input.userName));
  }
}

class RegisterUserCaseInput {
  final String userName;
  final String email;
  final String password;

  RegisterUserCaseInput({
    required this.email,
    required this.password,
    required this.userName,
  });
}
