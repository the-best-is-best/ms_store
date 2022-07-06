import 'package:ms_store/data/network/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/repository/repository.dart';

import '../../../data/network/requests/users_requests.dart';
import '../use_case.dart';

class UpdateUserDataUserCase
    implements BaseCase<UpdateUserDataUserCaseInput, bool> {
  final Repository _repository;

  UpdateUserDataUserCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(
      UpdateUserDataUserCaseInput input) async {
    return await _repository.updateUserData(UpdateUserRequests(
        id: input.id,
        userName: input.userName,
        phone: input.phone,
        phoneVerify: input.phoneVerify,
        password: input.password));
  }
}

class UpdateUserDataUserCaseInput {
  final int id;
  final String userName;
  final String phone;
  final int phoneVerify;
  final String password;

  UpdateUserDataUserCaseInput(
      {required this.id,
      required this.userName,
      required this.phone,
      required this.phoneVerify,
      required this.password});
}
