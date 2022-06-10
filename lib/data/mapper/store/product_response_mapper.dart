import '../../../app/extensions.dart';

import '../../../domain/models/home_models/product_model_home.dart';
import '../../responses/home_response/product_home_response.dart';

extension ProductHomeResponseMapper on ProductHomeResponse? {
  ProductModeHome toDomain() {
    return ProductModeHome(
        id: this?.id?.orEmpty() ?? 0,
        nameEN: this?.nameEN?.orEmpty() ?? "",
        nameAR: this?.nameAR?.orEmpty() ?? "",
        image: this?.image?.orEmpty() ?? "",
        price: this?.price?.orEmpty() ?? 0,
        priceAfterDis: this?.priceAfterDis?.orEmpty() ?? 0,
        descriptionEN: this?.descriptionEN?.orEmpty() ?? "",
        descriptionAR: this?.descriptionAR?.orEmpty() ?? "",
        categoryId: this?.categoryId?.orEmpty() ?? 0,
        offers: this?.offers?.orEmpty() ?? 0);
  }
}
