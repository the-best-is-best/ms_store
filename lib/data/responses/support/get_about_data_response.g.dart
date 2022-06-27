// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_about_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAboutDataResponse _$GetAboutDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetAboutDataResponse(
      json['data'] == null
          ? null
          : GetAboutResponse.fromJson(json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$GetAboutDataResponseToJson(
        GetAboutDataResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

GetAboutResponse _$GetAboutResponseFromJson(Map<String, dynamic> json) =>
    GetAboutResponse(
      json['textEN'] as String?,
      json['textAR'] as String?,
    );

Map<String, dynamic> _$GetAboutResponseToJson(GetAboutResponse instance) =>
    <String, dynamic>{
      'textEN': instance.textEN,
      'textAR': instance.textAR,
    };
