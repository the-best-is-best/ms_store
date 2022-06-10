// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_in_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataInHomeResponse _$DataInHomeResponseFromJson(Map<String, dynamic> json) =>
    DataInHomeResponse(
      json['category'] == null
          ? null
          : CategoryHomeResponse.fromJson(
              json['category'] as Map<String, dynamic>),
      (json['productsInCategory'] as List<dynamic>?)
          ?.map((e) => ProductHomeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataInHomeResponseToJson(DataInHomeResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'productsInCategory': instance.productsInCategory,
    };
