import 'package:json_annotation/json_annotation.dart';

import 'category_in_home_response.dart';
import 'product_home_response.dart';

part 'data_in_home_response.g.dart';

@JsonSerializable()
class DataInHomeResponse {
  CategoryHomeResponse? category;
  List<ProductHomeResponse>? productsInCategory;

  DataInHomeResponse(this.category, this.productsInCategory);

  factory DataInHomeResponse.fromJson(Map<String, dynamic> json) {
    return _$DataInHomeResponseFromJson(json);
  }
}
