import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/cart_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

import '../../../../../app/components.dart';
import '../../../../../data/data_src/local_data_source.dart';

class CartController extends GetxController {
  final LocalDataSource _localDataSource;
  RxMap<int, CartModel> cartModel = RxMap<int, CartModel>();
  RxList<ProductModel> productsInCart = RxList<ProductModel>();
  CartController(this._localDataSource);
  Future getCart() async {
    try {
      cartModel.value = await _localDataSource.getCartData();
    } catch (ex) {
      await _localDataSource.deleteCartData();
      await _localDataSource.deleteProductCartData();
    }
    try {
      productsInCart.value = await _localDataSource.getProductCartData();
    } catch (ex) {
      cartModel.value = {};
      await _localDataSource.deleteCartData();
      await _localDataSource.deleteProductCartData();
    }
  }

  Future saveCart() async {
    await _localDataSource.saveCartDataCache(cartModel);
    await _localDataSource.saveProductCartData(productsInCart);
  }

  RxBool isLoadingCart = false.obs;
  Rxn<int> productId = Rxn<int>();
  void addToCart(ProductModel productData, bool increase) async {
    isLoadingCart.value = true;
    productId.value = productData.id;
    if (cartModel.containsKey(productData.id)) {
      if (increase && cartModel[productData.id]!.quantity < 10) {
        cartModel[productData.id]!.quantity++;
      } else if (!increase && cartModel[productData.id]!.quantity > 1) {
        cartModel[productData.id]!.quantity--;
      }
      cartModel.refresh();
    } else {
      Map<int, CartModel> dataToAdd = {
        productData.id: CartModel(productData.id, 1)
      };
      cartModel.addAll(dataToAdd);
      productsInCart.add(productData);
    }
    await saveCart();
    await waitStateChanged(duration: 1000);

    isLoadingCart.value = false;
    productId.value = null;
    update();
  }
}
