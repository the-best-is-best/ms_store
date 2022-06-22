import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product_data_response.dart';

part 'get_products_supplies_response.g.dart';

@JsonSerializable()
class GetProductsSuppliesResponse extends BaseResponses {
  final List<ProductDataResponse>? data;

  GetProductsSuppliesResponse(this.data);
  factory GetProductsSuppliesResponse.fromJson(Map<String, dynamic> json) {
    return _$GetProductsSuppliesResponseFromJson(json);
  }
}
