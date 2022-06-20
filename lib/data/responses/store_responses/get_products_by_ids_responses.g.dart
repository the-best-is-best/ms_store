// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_by_ids_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductByIdsDataResponse _$GetProductByIdsDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductByIdsDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$GetProductByIdsDataResponseToJson(
        GetProductByIdsDataResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
