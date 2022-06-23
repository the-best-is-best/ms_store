import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_review_response.g.dart';

@JsonSerializable()
class UpdateReviewResponse extends BaseResponses {
  UpdateReviewResponse();
  factory UpdateReviewResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdateReviewResponseFromJson(json);
  }
}
