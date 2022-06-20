import 'package:json_annotation/json_annotation.dart';

import 'category_in_home_response.dart';
import '../store_responses/product_data_response.dart';

part 'data_in_home_response.g.dart';

@JsonSerializable()
class DataInHomeResponse {
  CategoryHomeResponse? category;
  List<ProductDataResponse>? productsInCategory;

  DataInHomeResponse(this.category, this.productsInCategory);

  factory DataInHomeResponse.fromJson(Map<String, dynamic> json) {
    return _$DataInHomeResponseFromJson(json);
  }
}
