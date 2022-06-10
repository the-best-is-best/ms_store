import 'package:json_annotation/json_annotation.dart';

part 'product_home_response.g.dart';

@JsonSerializable()
class ProductHomeResponse {
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
  factory ProductHomeResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductHomeResponseFromJson(json);
  }

  ProductHomeResponse(
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
