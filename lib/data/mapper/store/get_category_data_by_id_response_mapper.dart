import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/domain/models/store/category_model.dart';

import '../../responses/store_responses/get_category_data_by_id.dart';

extension GetCategoryDataByIdResponseMapper on GetCategoryDataByIdResponse? {
  CategoryDataModel toDomain() {
    return CategoryDataModel(
        id: this?.data?.id?.orEmpty() ?? 0,
        nameEN: this?.data?.nameEN?.orEmpty() ?? "",
        nameAR: this?.data?.nameAR?.orEmpty() ?? "",
        displayInHome: 0,
        image: '',
        parent: 0);
  }
}
