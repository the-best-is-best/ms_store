import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'response_delete_user.g.dart';

@JsonSerializable()
class DeleteUserResponse extends BaseResponses {
  DeleteUserResponse();
  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return _$DeleteUserResponseFromJson(json);
  }
}
