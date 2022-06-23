class ReviewsDataModel {
  final ReviewsModel data;

  ReviewsDataModel(this.data);
}

class ReviewsModel {
  final double productRating;
  final List<ReviewsProductModel> dataReview;

  ReviewsModel(this.productRating, this.dataReview);
}

class ReviewsProductModel {
  final int userId;
  final String userName;
  final double rating;
  final String comment;

  ReviewsProductModel(this.userId, this.rating, this.comment, this.userName);
}
