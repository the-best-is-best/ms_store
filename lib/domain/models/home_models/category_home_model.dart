import 'package:hive/hive.dart';
part 'category_home_model.g.dart';

@HiveType(typeId: 8)
class CategoryHomeModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String nameEN;
  @HiveField(2)
  final String nameAR;
  @HiveField(3)
  final int parent;
  @HiveField(4)
  final int displayInHome;
  @HiveField(5)
  final String image;
  CategoryHomeModel({
    required this.parent,
    required this.displayInHome,
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.image,
  });
}
