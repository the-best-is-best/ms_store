class FavoriteDataModel {
  final int productId;
  bool status;

  FavoriteDataModel(this.productId, this.status);
}

class FavoriteModel {
  final List<FavoriteDataModel> data;

  FavoriteModel(this.data);
}
