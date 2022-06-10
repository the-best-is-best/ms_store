import '../../../../app/extensions.dart';

import '../../../../domain/models/store/category_model.dart';
import '../../../responses/home_response/category_in_home_response.dart';

extension MainCatResponseMapper on CategoryHomeResponse? {
  CategoryModel toDomain() {
    return CategoryModel(
        id: this?.id?.orEmpty() ?? 0,
        nameEN: this?.nameEN?.orEmpty() ?? "",
        nameAR: this?.nameAR?.orEmpty() ?? "",
        parent: 0,
        image: "",
        displayInHome: 1);
  }
}
