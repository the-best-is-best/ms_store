import '../../../data/network/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../data/network/requests/users_requests.dart';
import '../../models/users_model.dart';
import '../../repository/repository.dart';
import '../use_case.dart';

class ActiveEmailCase implements BaseCase<ActiveEmailCaseInput, UserModel> {
  final Repository _repository;

  ActiveEmailCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> execute(input) async {
    return await _repository
        .activeEmail(ActiveEmailRequests(email: input.email, pin: input.pin));
  }
}

class ActiveEmailCaseInput {
  final String email;
  final String pin;

  ActiveEmailCaseInput(this.email, this.pin);
}
