import 'package:json_annotation/json_annotation.dart';
part 'create_order_response.g.dart';

@JsonSerializable()
class PayMobRequestCreateOrderResponse {
  @JsonKey(name: 'token')
  final String lastToken;

  PayMobRequestCreateOrderResponse(this.lastToken);
  factory PayMobRequestCreateOrderResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PayMobRequestCreateOrderResponseFromJson(json);
}
