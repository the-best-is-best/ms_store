// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductHomeResponse _$ProductHomeResponseFromJson(Map<String, dynamic> json) =>
    ProductHomeResponse(
      id: json['id'] as int?,
      nameEN: json['nameEN'] as String?,
      nameAR: json['nameAR'] as String?,
      image: json['image'] as String?,
      price: json['price'] as num?,
      priceAfterDis: json['price_after_dis'] as num?,
      descriptionEN: json['descriptionEN'] as String?,
      descriptionAR: json['descriptionAR'] as String?,
      categoryId: json['categoryId'] as int?,
      offers: json['offers'] as int?,
    );

Map<String, dynamic> _$ProductHomeResponseToJson(
        ProductHomeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEN': instance.nameEN,
      'nameAR': instance.nameAR,
      'image': instance.image,
      'price': instance.price,
      'price_after_dis': instance.priceAfterDis,
      'descriptionEN': instance.descriptionEN,
      'descriptionAR': instance.descriptionAR,
      'categoryId': instance.categoryId,
      'offers': instance.offers,
    };
