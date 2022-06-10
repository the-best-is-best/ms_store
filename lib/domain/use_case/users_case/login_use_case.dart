import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/users_requests.dart';
import '../../models/users_model.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class LoginUserCase implements BaseCase<LoginUserCaseInput, UserModel> {
  final Repository _repository;

  LoginUserCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> execute(LoginUserCaseInput input) async {
    return await _repository.login(LoginRequests(input.email, input.password));
  }
}

class LoginUserCaseInput {
  final String email;
  final String password;

  LoginUserCaseInput(this.email, this.password);
}
