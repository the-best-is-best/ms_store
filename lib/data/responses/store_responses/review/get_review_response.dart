import 'package:ms_store/data/responses/base/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_review_response.g.dart';

@JsonSerializable()
class GetReviewsDataModelResponse extends BaseResponses {
  final GetReviewsModelResponse? data;

  GetReviewsDataModelResponse(this.data);
  factory GetReviewsDataModelResponse.fromJson(Map<String, dynamic> json) {
    return _$GetReviewsDataModelResponseFromJson(json);
  }
}

@JsonSerializable()
class GetReviewsModelResponse {
  final double? productRating;
  final List<GetReviewsProductModelResponse>? dataReview;

  GetReviewsModelResponse(this.productRating, this.dataReview);
  factory GetReviewsModelResponse.fromJson(Map<String, dynamic> json) {
    return _$GetReviewsModelResponseFromJson(json);
  }
}

@JsonSerializable()
class GetReviewsProductModelResponse {
  final int? userId;
  final String? userName;
  final double? rating;
  final String? comment;

  GetReviewsProductModelResponse(
      this.userId, this.rating, this.comment, this.userName);
  factory GetReviewsProductModelResponse.fromJson(Map<String, dynamic> json) {
    return _$GetReviewsProductModelResponseFromJson(json);
  }
}
