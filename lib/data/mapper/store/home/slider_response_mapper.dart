import '../../../../app/extensions.dart';

import '../../../../domain/models/home_models/slider_model.dart';
import '../../../responses/home_response/slider_response.dart';

extension SliderResponseMapper on SliderResponse? {
  SliderModel toDomain() {
    return SliderModel(
        id: this?.id?.orEmpty() ?? 0,
        imageEN: this?.imageEN?.orEmpty() ?? "",
        imageAR: this?.imageAR?.orEmpty() ?? "",
        openCategoryId: this?.openCategoryId?.orEmpty(),
        openProductId: this?.openProductId);
  }
}
