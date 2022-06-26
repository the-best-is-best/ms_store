// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_category_data_by_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoryDataByIdResponse _$GetCategoryDataByIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetCategoryDataByIdResponse(
      json['data'] == null
          ? null
          : CategoriesDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$GetCategoryDataByIdResponseToJson(
        GetCategoryDataByIdResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
