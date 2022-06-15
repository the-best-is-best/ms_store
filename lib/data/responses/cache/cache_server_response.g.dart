// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_server_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheServerDataResponse _$CacheServerDataResponseFromJson(
        Map<String, dynamic> json) =>
    CacheServerDataResponse(
      json['cacheKeyServer'] as String?,
    );

Map<String, dynamic> _$CacheServerDataResponseToJson(
        CacheServerDataResponse instance) =>
    <String, dynamic>{
      'cacheKeyServer': instance.cacheKeyServer,
    };

CacheServerResponse _$CacheServerResponseFromJson(Map<String, dynamic> json) =>
    CacheServerResponse(
      json['data'] == null
          ? null
          : CacheServerDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$CacheServerResponseToJson(
        CacheServerResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
