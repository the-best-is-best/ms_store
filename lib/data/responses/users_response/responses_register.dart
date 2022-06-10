import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'responses_register.g.dart';

@JsonSerializable()
class RegisterResponse extends BaseResponses {
  RegisterResponse();
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseFromJson(json);
  }
}
