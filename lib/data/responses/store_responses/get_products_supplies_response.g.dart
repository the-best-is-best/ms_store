// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_supplies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsSuppliesResponse _$GetProductsSuppliesResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductsSuppliesResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$GetProductsSuppliesResponseToJson(
        GetProductsSuppliesResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
