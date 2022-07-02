// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_with_pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductWithPaginationResponse _$ProductWithPaginationResponseFromJson(
        Map<String, dynamic> json) =>
    ProductWithPaginationResponse(
      (json['products'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalPages'] as int?,
    );

Map<String, dynamic> _$ProductWithPaginationResponseToJson(
        ProductWithPaginationResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
      'totalPages': instance.totalPages,
    };

ProductWithPaginationDataResponse _$ProductWithPaginationDataResponseFromJson(
        Map<String, dynamic> json) =>
    ProductWithPaginationDataResponse(
      json['data'] == null
          ? null
          : ProductWithPaginationResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$ProductWithPaginationDataResponseToJson(
        ProductWithPaginationDataResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
