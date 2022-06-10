import 'package:json_annotation/json_annotation.dart';

part 'slider_response.g.dart';

@JsonSerializable()
class SliderResponse {
  final int? id;
  final String? imageEN;
  final String? imageAR;
  @JsonKey(name: "open_category_id")
  final int? openCategoryId;
  @JsonKey(name: "open_product_id")
  final int? openProductId;

  SliderResponse(
      {this.id,
      this.imageEN,
      this.imageAR,
      this.openCategoryId,
      this.openProductId});
  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return _$SliderResponseFromJson(json);
  }
}
