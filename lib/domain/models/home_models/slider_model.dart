class SliderModel {
  final int id;
  final String imageEN;
  final String imageAR;
  final int? openProductId;
  final int? openCategoryId;

  SliderModel(
      {required this.id,
      required this.imageEN,
      required this.imageAR,
      required this.openProductId,
      required this.openCategoryId});
}
