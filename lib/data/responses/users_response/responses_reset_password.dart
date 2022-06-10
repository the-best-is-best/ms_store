import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'responses_reset_password.g.dart';

@JsonSerializable()
class ResetPasswordResponse extends BaseResponses {
  ResetPasswordResponse();
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordResponseFromJson(json);
  }
}
