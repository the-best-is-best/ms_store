import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 14)
class CartModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int productId;
  @HiveField(2)
  final int quantity;

  CartModel(this.id, this.productId, this.quantity);
}
