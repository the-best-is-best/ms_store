import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ms_store/data/responses/store_responses/product_data_response.dart';

part 'get_products_by_cat_id_response.g.dart';

@JsonSerializable()
class GetProductCatIdResponse {
  final List<ProductDataResponse>? products;
  final int? totalPages;
  GetProductCatIdResponse(this.products, this.totalPages);
  factory GetProductCatIdResponse.fromJson(Map<String, dynamic> json) {
    return _$GetProductCatIdResponseFromJson(json);
  }
}

@JsonSerializable()
class GetProductCatIdDataResponse extends BaseResponses {
  final GetProductCatIdResponse? data;
  GetProductCatIdDataResponse(this.data);
  factory GetProductCatIdDataResponse.fromJson(Map<String, dynamic> json) {
    return _$GetProductCatIdDataResponseFromJson(json);
  }
}
