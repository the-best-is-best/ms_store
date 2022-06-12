import 'package:hive/hive.dart';

part 'product_home_model.g.dart';

@HiveType(typeId: 6)
class ProductHomeModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nameEN;
  @HiveField(2)
  final String nameAR;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final num price;
  @HiveField(5)
  final num priceAfterDis;
  @HiveField(6)
  final String descriptionEN;
  @HiveField(7)
  final String descriptionAR;
  @HiveField(8)
  final int categoryId;
  @HiveField(9)
  final int offers;
  ProductHomeModel(
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
