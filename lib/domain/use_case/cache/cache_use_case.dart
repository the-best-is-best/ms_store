import 'package:ms_store/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/cache/cache_data.dart';
import 'package:ms_store/domain/use_case/use_case.dart';

import '../../repository/repository.dart';

class CacheUserCase extends BaseCase<Function?, CheckCachedDataServer> {
  final Repository _repository;

  CacheUserCase(this._repository);
  @override
  Future<Either<Failure, CheckCachedDataServer>> execute(
      Function? input) async {
    return await _repository.cache();
  }
}
