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
