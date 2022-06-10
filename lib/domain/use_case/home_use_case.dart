import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/home_models/home_data_model.dart';
import '../repository/repository.dart';
import 'use_case.dart';

class HomeUseCase implements BaseCase<Function?, HomeModel> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeModel>> execute(input) async {
    return await _repository.getHomeData();
  }
}
