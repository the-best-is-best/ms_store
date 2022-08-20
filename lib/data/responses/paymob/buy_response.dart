import 'package:json_annotation/json_annotation.dart';
part 'buy_response.g.dart';

@JsonSerializable()
class BuyResponse {
  final int id;

  BuyResponse(this.id);
  factory BuyResponse.fromJson(Map<String, dynamic> json) =>
      _$BuyResponseFromJson(json);
}
