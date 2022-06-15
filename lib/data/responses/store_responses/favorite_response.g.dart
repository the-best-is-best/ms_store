// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteAddResponse _$FavoriteAddResponseFromJson(Map<String, dynamic> json) =>
    FavoriteAddResponse()..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$FavoriteAddResponseToJson(
        FavoriteAddResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
    };

FavoriteDataResponse _$FavoriteDataResponseFromJson(
        Map<String, dynamic> json) =>
    FavoriteDataResponse(
      json['id'] as int?,
      json['productId'] as int?,
      json['status'] as int?,
    );

Map<String, dynamic> _$FavoriteDataResponseToJson(
        FavoriteDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'status': instance.status,
    };

FavoriteGetResponse _$FavoriteGetResponseFromJson(Map<String, dynamic> json) =>
    FavoriteGetResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => FavoriteDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$FavoriteGetResponseToJson(
        FavoriteGetResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
