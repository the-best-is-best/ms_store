import 'package:json_annotation/json_annotation.dart';

part 'product_data_response.g.dart';

@JsonSerializable()
class ProductDataResponse {
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
  final int? stock;
  factory ProductDataResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductDataResponseFromJson(json);
  }

  ProductDataResponse(
      {this.id,
      this.nameEN,
      this.nameAR,
      this.image,
      this.price,
      this.priceAfterDis,
      this.descriptionEN,
      this.descriptionAR,
      this.categoryId,
      this.offers,
      this.stock});
}
