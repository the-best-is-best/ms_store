import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/users_requests.dart';
import '../../models/users_model.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class LoginBySocialUserCase
    implements BaseCase<LoginBySocialUserCaseInput, UserModel> {
  final Repository _repository;

  LoginBySocialUserCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> execute(
      LoginBySocialUserCaseInput input) async {
    return await _repository.loginBySocial(LoginBySocialRequests(
        email: input.email,
        loginBySocial: input.loginBySocial,
        tokenSocial: input.tokenSocial,
        userName: input.userName));
  }
}

class LoginBySocialUserCaseInput {
  final String email;
  final String userName;
  final int loginBySocial;
  final String tokenSocial;

  LoginBySocialUserCaseInput(
      {required this.email,
      required this.userName,
      required this.loginBySocial,
      required this.tokenSocial});
}
