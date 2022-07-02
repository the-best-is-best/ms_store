import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ms_store/data/responses/store_responses/product_data_response.dart';

part 'get_products_with_pagination_response.g.dart';

@JsonSerializable()
class ProductWithPaginationResponse {
  final List<ProductDataResponse>? products;
  final int? totalPages;
  ProductWithPaginationResponse(this.products, this.totalPages);
  factory ProductWithPaginationResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductWithPaginationResponseFromJson(json);
  }
}

@JsonSerializable()
class ProductWithPaginationDataResponse extends BaseResponses {
  final ProductWithPaginationResponse? data;
  ProductWithPaginationDataResponse(this.data);
  factory ProductWithPaginationDataResponse.fromJson(
      Map<String, dynamic> json) {
    return _$ProductWithPaginationDataResponseFromJson(json);
  }
}
