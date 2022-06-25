// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_by_cat_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductCatIdResponse _$GetProductCatIdResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductCatIdResponse(
      (json['products'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalPages'] as int?,
    );

Map<String, dynamic> _$GetProductCatIdResponseToJson(
        GetProductCatIdResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
      'totalPages': instance.totalPages,
    };

GetProductCatIdDataResponse _$GetProductCatIdDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductCatIdDataResponse(
      json['data'] == null
          ? null
          : GetProductCatIdResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$GetProductCatIdDataResponseToJson(
        GetProductCatIdDataResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
