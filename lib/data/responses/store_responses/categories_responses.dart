import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'categories_responses.g.dart';

@JsonSerializable()
class CategoriesDataResponse {
  final int? id;
  final String? nameEN;
  final String? nameAR;
  final int? parent;
  final int? displayInHome;
  final String? image;

  CategoriesDataResponse(this.id, this.nameEN, this.nameAR, this.image,
      this.parent, this.displayInHome);

  factory CategoriesDataResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesDataResponseFromJson(json);
  }
}

@JsonSerializable()
class CategoriesDataWithChildResponse {
  final int? id;
  final String? nameEN;
  final String? nameAR;
  final int? parent;
  final int? displayInHome;
  final String? image;
  List<CategoriesDataResponse>? childCat;

  CategoriesDataWithChildResponse(this.id, this.nameEN, this.nameAR, this.image,
      this.parent, this.displayInHome, this.childCat);

  factory CategoriesDataWithChildResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesDataWithChildResponseFromJson(json);
  }
}

@JsonSerializable()
class CategoriesResponse extends BaseResponses {
  final List<CategoriesDataWithChildResponse>? data;

  CategoriesResponse(
    this.data,
  );

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseFromJson(json);
  }
}
