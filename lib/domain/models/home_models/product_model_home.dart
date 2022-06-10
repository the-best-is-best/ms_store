class ProductModeHome {
  final int id;
  final String nameEN;
  final String nameAR;
  final String image;
  final num price;
  final num priceAfterDis;
  final String descriptionEN;
  final String descriptionAR;
  final int categoryId;
  final int offers;

  ProductModeHome(
      {required this.id,
      required this.nameEN,
      required this.nameAR,
      required this.image,
      required this.price,
      required this.priceAfterDis,
      required this.descriptionEN,
      required this.descriptionAR,
      required this.categoryId,
      required this.offers});
}
