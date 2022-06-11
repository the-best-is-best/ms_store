import 'package:hive/hive.dart';

part 'slider_model.g.dart';

@HiveType(typeId: 3)
class SliderModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String imageEN;
  @HiveField(2)
  final String imageAR;
  @HiveField(3)
  final int? openProductId;
  @HiveField(4)
  final int? openCategoryId;

  SliderModel(
      {required this.id,
      required this.imageEN,
      required this.imageAR,
      required this.openProductId,
      required this.openCategoryId});
}
