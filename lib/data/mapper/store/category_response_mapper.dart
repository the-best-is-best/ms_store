import '../../../app/extensions.dart';

import '../../../domain/models/store/category_model.dart';
import '../../responses/store_responses/categories_responses.dart';

extension CatagoriesResponseMapper on CategoriesResponse? {
  List<CategoryModel> toDomain() {
    return (this?.data?.map((catResponse) {
              return CategoryModel(
                  parent: catResponse.parent?.orEmpty() ?? 0,
                  displayInHome: catResponse.displayInHome?.orEmpty() ?? 0,
                  id: catResponse.id?.orEmpty() ?? 0,
                  nameEN: catResponse.nameEN?.orEmpty() ?? "",
                  nameAR: catResponse.nameAR?.orEmpty() ?? "",
                  image: catResponse.image?.orEmpty() ?? "");
            }) ??
            const Iterable.empty())
        .cast<CategoryModel>()
        .toList();
  }
}
