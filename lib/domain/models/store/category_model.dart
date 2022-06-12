import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 9)
class CategoryDataWithChildModel {
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
  @HiveField(6)
  final List<CategoryDataModel> childCat;
  CategoryDataWithChildModel({
    required this.parent,
    required this.displayInHome,
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.image,
    required this.childCat,
  });
}

@HiveType(typeId: 10)
class CategoryDataModel {
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
  CategoryDataModel({
    required this.parent,
    required this.displayInHome,
    required this.id,
    required this.nameEN,
    required this.nameAR,
    required this.image,
  });
}

@HiveType(typeId: 11)
class CategoryModel {
  @HiveField(0)
  final List<CategoryDataWithChildModel>? data;
  CategoryModel({
    required this.data,
  });
}
