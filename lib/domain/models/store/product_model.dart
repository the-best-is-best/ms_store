import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 5)
class ProductModel {
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
  @HiveField(10)
  final int stock;

  ProductModel({
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.image,
    required this.price,
    required this.priceAfterDis,
    required this.descriptionEN,
    required this.descriptionAR,
    required this.categoryId,
    required this.offers,
    required this.stock,
  });
}
