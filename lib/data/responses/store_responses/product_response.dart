import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse extends BaseResponses {
  final int? id;
  final String? nameEN;
  final String? nameAR;
  final String? image;
  final num? price;
  @JsonKey(name: "price_after_dis")
  final num? priceAfterDis;
  final String? descriptionEN;
  final String? descriptionAR;
  final int? categoryId;
  final int? offers;
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductResponseFromJson(json);
  }

  ProductResponse(
      {this.id,
      this.nameEN,
      this.nameAR,
      this.image,
      this.price,
      this.priceAfterDis,
      this.descriptionEN,
      this.descriptionAR,
      this.categoryId,
      this.offers});
}
