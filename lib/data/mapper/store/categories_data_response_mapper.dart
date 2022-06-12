import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/domain/models/store/category_model.dart';

import '../../../domain/models/store/category_model.dart';
import '../../responses/store_responses/categories_responses.dart';

extension CategoriesDataWithChildResponseMapper
    on CategoriesDataWithChildResponse? {
  CategoryDataWithChildModel toDomain() {
    return CategoryDataWithChildModel(
      id: this?.id?.orEmpty() ?? 0,
      nameEN: this?.nameEN?.orEmpty() ?? "",
      nameAR: this?.nameAR?.orEmpty() ?? "",
      image: this?.image?.orEmpty() ?? "",
      parent: this?.parent.orEmpty() ?? 0,
      displayInHome: this?.displayInHome?.orEmpty() ?? 0,
      childCat: this?.childCat?.map((e) => e.toDomain()).toList() ??
          const Iterable.empty().cast<CategoryDataModel>().toList(),
    );
  }
}

extension CategoriesDataResponseMapper on CategoriesDataResponse? {
  CategoryDataModel toDomain() {
    return CategoryDataModel(
      id: this?.id?.orEmpty() ?? 0,
      nameEN: this?.nameEN?.orEmpty() ?? "",
      nameAR: this?.nameAR?.orEmpty() ?? "",
      image: this?.image?.orEmpty() ?? "",
      parent: this?.parent.orEmpty() ?? 0,
      displayInHome: this?.displayInHome?.orEmpty() ?? 0,
    );
  }
}

extension CategoriesResponseMapper on CategoriesResponse? {
  CategoryModel toDomain() {
    return CategoryModel(
      data: this?.data?.map((e) => e.toDomain()).toList() ??
          const Iterable.empty().cast<CategoryDataWithChildModel>().toList(),
    );
  }
}
