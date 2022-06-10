import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'responses_users.g.dart';

@JsonSerializable()
class UsersDataResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "loginBySocial", defaultValue: 0)
  final int? loginBySocial;
  @JsonKey(name: "tokenSocial")
  final String? tokenSocial;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "code")
  String? code;
  @override
  UsersDataResponse({
    this.id,
    this.loginBySocial,
    this.tokenSocial,
    this.userName,
    this.email,
    this.password,
    this.phone,
    this.code,
  });

  factory UsersDataResponse.fromJson(Map<String, dynamic> json) {
    return _$UsersDataResponseFromJson(json);
  }

  // Map<String, dynamic> toJson() => _$UsersResponseToJson(this);
}

@JsonSerializable()
class UsersResponse extends BaseResponses {
  final UsersDataResponse? data;

  UsersResponse(this.data);
  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    return _$UsersResponseFromJson(json);
  }
}
