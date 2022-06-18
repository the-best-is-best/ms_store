import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 14)
class CartModel {
  @HiveField(0)
  final int productId;
  @HiveField(1)
  int quantity;
  CartModel(this.productId, this.quantity);
}
