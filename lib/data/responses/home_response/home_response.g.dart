// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataResponseWithSlider _$HomeDataResponseWithSliderFromJson(
        Map<String, dynamic> json) =>
    HomeDataResponseWithSlider(
      (json['slider'] as List<dynamic>?)
          ?.map((e) => SliderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['dataHome'] as List<dynamic>?)
          ?.map((e) => DataInHomeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDataResponseWithSliderToJson(
        HomeDataResponseWithSlider instance) =>
    <String, dynamic>{
      'slider': instance.slider,
      'dataHome': instance.dataHome,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      json['data'] == null
          ? null
          : HomeDataResponseWithSlider.fromJson(
              json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };
