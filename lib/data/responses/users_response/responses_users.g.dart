// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersDataResponse _$UsersDataResponseFromJson(Map<String, dynamic> json) =>
    UsersDataResponse(
      id: json['id'] as int?,
      loginBySocial: json['loginBySocial'] as int? ?? 0,
      tokenSocial: json['tokenSocial'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      phoneVerify: json['phoneVerify'] as int?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$UsersDataResponseToJson(UsersDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loginBySocial': instance.loginBySocial,
      'tokenSocial': instance.tokenSocial,
      'userName': instance.userName,
      'email': instance.email,
      'phone': instance.phone,
      'phoneVerify': instance.phoneVerify,
      'password': instance.password,
      'code': instance.code,
    };

UsersResponse _$UsersResponseFromJson(Map<String, dynamic> json) =>
    UsersResponse(
      json['data'] == null
          ? null
          : UsersDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$UsersResponseToJson(UsersResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
