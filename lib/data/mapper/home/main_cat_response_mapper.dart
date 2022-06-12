import '../../../../app/extensions.dart';

import '../../../../domain/models/home_models/category_home_model.dart';
import '../../responses/home_response/category_in_home_response.dart';

extension MainCatResponseMapper on CategoryHomeResponse? {
  CategoryHomeModel toDomain() {
    return CategoryHomeModel(
        id: this?.id?.orEmpty() ?? 0,
        nameEN: this?.nameEN?.orEmpty() ?? "",
        nameAR: this?.nameAR?.orEmpty() ?? "",
        parent: 0,
        image: "",
        displayInHome: 1);
  }
}
