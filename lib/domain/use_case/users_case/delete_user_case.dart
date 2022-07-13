import 'package:dartz/dartz.dart';

import '../../../data/network/failure.dart';
import '../../../data/network/requests/users_requests.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class DeleteUserCase implements BaseCase<DeleteUserCaseInput, bool> {
  final Repository _repository;
  DeleteUserCase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(DeleteUserCaseInput input) async {
    return await _repository.deleteUser(DeleteUserRequests(input.userId));
  }
}

class DeleteUserCaseInput {
  final int userId;

  DeleteUserCaseInput(this.userId);
}
