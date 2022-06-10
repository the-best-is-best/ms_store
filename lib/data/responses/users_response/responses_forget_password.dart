import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'responses_forget_password.g.dart';

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponses {
  ForgetPasswordResponse();
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ForgetPasswordResponseFromJson(json);
  }
}
