import 'package:json_annotation/json_annotation.dart';
part 'order_registration_response.g.dart';

@JsonSerializable()
class OrderRegistrationResponse {
  final int id;
  OrderRegistrationResponse(this.id);

  factory OrderRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderRegistrationResponseFromJson(json);
}
