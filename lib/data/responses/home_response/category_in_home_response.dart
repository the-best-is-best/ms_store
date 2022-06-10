import 'package:json_annotation/json_annotation.dart';
part 'category_in_home_response.g.dart';

@JsonSerializable()
class CategoryHomeResponse {
  final int? id;
  final String? nameEN;
  final String? nameAR;

  CategoryHomeResponse(this.id, this.nameEN, this.nameAR);

  factory CategoryHomeResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoryHomeResponseFromJson(json);
  }
}
