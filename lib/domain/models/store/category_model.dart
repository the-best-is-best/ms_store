class CategoryModel {
  final int id;
  final String nameEN;
  final String nameAR;
  final int parent;
  final int displayInHome;
  final String image;

  CategoryModel({
    required this.parent,
    required this.displayInHome,
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.image,
  });
}
