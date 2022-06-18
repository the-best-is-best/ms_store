import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/cart_model.dart';

import '../../../../../data/data_src/local_data_source.dart';

class CartController extends GetxController {
  final LocalDataSource _localDataSource;
  RxMap<int, CartModel> cartModel = RxMap<int, CartModel>();

  CartController(this._localDataSource);
  Future getCart() async {
    try {
      cartModel.value = await _localDataSource.getCartData();
    } catch (ex) {
      print(ex);
    }
  }

  Future saveCart() async {
    await _localDataSource.saveCartDataCache(cartModel);
  }

  void addToCart(int productId, bool increase) {
    if (cartModel.containsKey(productId)) {
      if (increase) {
        cartModel[productId]!.quantity++;
      } else {
        cartModel[productId]!.quantity--;
      }
      cartModel.refresh();
    } else {
      Map<int, CartModel> dataToAdd = {productId: CartModel(productId, 1)};
      cartModel.addAll(dataToAdd);
    }
    saveCart();
  }
}
