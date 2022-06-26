import 'package:ms_store/data/responses/base/base_response.dart';

import 'categories_responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_category_data_by_id.g.dart';

@JsonSerializable()
class GetCategoryDataByIdResponse extends BaseResponses {
  final CategoriesDataResponse? data;

  GetCategoryDataByIdResponse(this.data);
  factory GetCategoryDataByIdResponse.fromJson(Map<String, dynamic> json) {
    return _$GetCategoryDataByIdResponseFromJson(json);
  }
}
