// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesDataResponse _$CategoriesDataResponseFromJson(
        Map<String, dynamic> json) =>
    CategoriesDataResponse(
      json['id'] as int?,
      json['nameEN'] as String?,
      json['nameAR'] as String?,
      json['image'] as String?,
      json['parent'] as int?,
      json['displayInHome'] as int?,
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$CategoriesDataResponseToJson(
        CategoriesDataResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'id': instance.id,
      'nameEN': instance.nameEN,
      'nameAR': instance.nameAR,
      'parent': instance.parent,
      'displayInHome': instance.displayInHome,
      'image': instance.image,
    };

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      (json['data'] as List<dynamic>?)
          ?.map(
              (e) => CategoriesDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
