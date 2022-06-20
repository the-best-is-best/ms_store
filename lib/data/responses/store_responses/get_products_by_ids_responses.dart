import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ms_store/data/responses/store_responses/product_data_response.dart';

part 'get_products_by_ids_responses.g.dart';

@JsonSerializable()
class GetProductByIdsDataResponse extends BaseResponses {
  final List<ProductDataResponse>? data;

  factory GetProductByIdsDataResponse.fromJson(Map<String, dynamic> json) {
    return _$GetProductByIdsDataResponseFromJson(json);
  }

  GetProductByIdsDataResponse(
    this.data,
  );
}
