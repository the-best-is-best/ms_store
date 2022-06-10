// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderResponse _$SliderResponseFromJson(Map<String, dynamic> json) =>
    SliderResponse(
      id: json['id'] as int?,
      imageEN: json['imageEN'] as String?,
      imageAR: json['imageAR'] as String?,
      openCategoryId: json['open_category_id'] as int?,
      openProductId: json['open_product_id'] as int?,
    );

Map<String, dynamic> _$SliderResponseToJson(SliderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageEN': instance.imageEN,
      'imageAR': instance.imageAR,
      'open_category_id': instance.openCategoryId,
      'open_product_id': instance.openProductId,
    };
