class GetProductByIdsRequests {
  final Map<String, int> ids;

  GetProductByIdsRequests(this.ids);
}

class GetProductsSupplierRequests {
  final int categoryId;

  GetProductsSupplierRequests(this.categoryId);
}

class AddFavoriteRequests {
  final int userId;
  final int productId;

  AddFavoriteRequests({
    required this.userId,
    required this.productId,
  });
}

class GetFavoriteRequests {
  final int userId;

  GetFavoriteRequests(
    this.userId,
  );
}

class GetReviewRequests {
  final int productId;

  GetReviewRequests(
    this.productId,
  );
}

class UpdateReviewRequests {
  final int userId;
  final bool status;
  final int productId;
  final double rating;
  final String comment;

  UpdateReviewRequests({
    required this.productId,
    required this.userId,
    required this.status,
    required this.rating,
    required this.comment,
  });
}

class GetProductsByCatIdRequests {
  final int catId;

  GetProductsByCatIdRequests(
    this.catId,
  );
}

class GetCategoryDataByIdRequests {
  final int catId;

  GetCategoryDataByIdRequests(
    this.catId,
  );
}
