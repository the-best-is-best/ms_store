// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReviewsDataModelResponse _$GetReviewsDataModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetReviewsDataModelResponse(
      json['data'] == null
          ? null
          : GetReviewsModelResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    )..statusCode = json['statusCode'] as int?;

Map<String, dynamic> _$GetReviewsDataModelResponseToJson(
        GetReviewsDataModelResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'data': instance.data,
    };

GetReviewsModelResponse _$GetReviewsModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetReviewsModelResponse(
      (json['productRating'] as num?)?.toDouble(),
      (json['dataReview'] as List<dynamic>?)
          ?.map((e) => GetReviewsProductModelResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetReviewsModelResponseToJson(
        GetReviewsModelResponse instance) =>
    <String, dynamic>{
      'productRating': instance.productRating,
      'dataReview': instance.dataReview,
    };

GetReviewsProductModelResponse _$GetReviewsProductModelResponseFromJson(
        Map<String, dynamic> json) =>
    GetReviewsProductModelResponse(
      json['userId'] as int?,
      (json['rating'] as num?)?.toDouble(),
      json['comment'] as String?,
      json['userName'] as String?,
    );

Map<String, dynamic> _$GetReviewsProductModelResponseToJson(
        GetReviewsProductModelResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'rating': instance.rating,
      'comment': instance.comment,
    };
