import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'create_orders_response.g.dart';

@JsonSerializable()
class CreateOrdersResponse extends BaseResponses {
  final int? id;
  CreateOrdersResponse(this.id);

  factory CreateOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateOrdersResponseFromJson(json);
  }
}
