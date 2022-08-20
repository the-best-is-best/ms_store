// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrdersResponse _$CreateOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    CreateOrdersResponse(
      json['id'] as int?,
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$CreateOrdersResponseToJson(
        CreateOrdersResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'id': instance.id,
    };
