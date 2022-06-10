import 'package:dartz/dartz.dart';

import '../../../../data/network/failure.dart';
import '../../../models/store/category_model.dart';
import '../../../repository/repository.dart';
import '../../use_case.dart';

class CategoryUseCase implements BaseCase<Function?, List<CategoryModel>> {
  final Repository _repository;

  CategoryUseCase(this._repository);
  @override
  Future<Either<Failure, List<CategoryModel>>> execute(Function? input) async {
    return await _repository.getCategoryData();
  }
}
