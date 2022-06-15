import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteAddResponse extends BaseResponses {
  FavoriteAddResponse();
  factory FavoriteAddResponse.fromJson(Map<String, dynamic> json) {
    return _$FavoriteAddResponseFromJson(json);
  }
}

@JsonSerializable()
class FavoriteDataResponse {
  final int? id;
  final int? productId;
  final int? status;

  FavoriteDataResponse(this.id, this.productId, this.status);
  factory FavoriteDataResponse.fromJson(Map<String, dynamic> json) {
    return _$FavoriteDataResponseFromJson(json);
  }
}

@JsonSerializable()
class FavoriteGetResponse extends BaseResponses {
  final List<FavoriteDataResponse>? data;
  FavoriteGetResponse(this.data);
  factory FavoriteGetResponse.fromJson(Map<String, dynamic> json) {
    return _$FavoriteGetResponseFromJson(json);
  }
}
