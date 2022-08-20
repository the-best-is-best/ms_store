import 'package:json_annotation/json_annotation.dart';
part 'get_first_token.g.dart';

@JsonSerializable()
class GetFirstTokenResponse {
  final String token;

  GetFirstTokenResponse(this.token);

  factory GetFirstTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFirstTokenResponseFromJson(json);
}
