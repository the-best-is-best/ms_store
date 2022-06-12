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
    );

Map<String, dynamic> _$CategoriesDataResponseToJson(
        CategoriesDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEN': instance.nameEN,
      'nameAR': instance.nameAR,
      'parent': instance.parent,
      'displayInHome': instance.displayInHome,
      'image': instance.image,
    };

CategoriesDataWithChildResponse _$CategoriesDataWithChildResponseFromJson(
        Map<String, dynamic> json) =>
    CategoriesDataWithChildResponse(
      json['id'] as int?,
      json['nameEN'] as String?,
      json['nameAR'] as String?,
      json['image'] as String?,
      json['parent'] as int?,
      json['displayInHome'] as int?,
      (json['childCat'] as List<dynamic>?)
          ?.map(
              (e) => CategoriesDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesDataWithChildResponseToJson(
        CategoriesDataWithChildResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEN': instance.nameEN,
      'nameAR': instance.nameAR,
      'parent': instance.parent,
      'displayInHome': instance.displayInHome,
      'image': instance.image,
      'childCat': instance.childCat,
    };

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CategoriesDataWithChildResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
