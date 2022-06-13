import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_add_response.g.dart';

@JsonSerializable()
class FavoriteAddResponse extends BaseResponses {
  FavoriteAddResponse();
  factory FavoriteAddResponse.fromJson(Map<String, dynamic> json) {
    return _$FavoriteAddResponseFromJson(json);
  }
}
