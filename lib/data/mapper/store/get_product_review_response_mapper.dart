import 'package:ms_store/app/extensions.dart';
import '../../../domain/models/store/reviews_model.dart';
import '../../responses/store_responses/review/get_review_response.dart';

extension GetProductReviewResponseMapper on GetReviewsProductModelResponse? {
  ReviewsProductModel toDomain() {
    return ReviewsProductModel(
        this?.userId?.orEmpty() ?? 0,
        this?.rating?.orEmpty() ?? 0,
        this?.comment?.orEmpty() ?? "",
        this?.userName?.orEmpty() ?? "");
  }
}

extension GetReviewsModelResponseMapper on GetReviewsDataModelResponse? {
  ReviewsModel toDomain() {
    return ReviewsModel(
        this?.data?.productRating?.orEmpty() ?? 0,
        this?.data?.dataReview?.map((e) => e.toDomain()).toList() ??
            List.empty().cast<ReviewsProductModel>());
  }
}
