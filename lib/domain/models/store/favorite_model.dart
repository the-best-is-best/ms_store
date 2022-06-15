import 'package:hive_flutter/adapters.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 12)
class FavoriteDataModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int productId;
  @HiveField(2)
  bool status;

  FavoriteDataModel(this.id, this.productId, this.status);
}

@HiveType(typeId: 13)
class FavoriteModel {
  @HiveField(0)
  final List<FavoriteDataModel> data;

  FavoriteModel(this.data);
}
