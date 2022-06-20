import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

import '../../../../../app/components.dart';
import '../../../../../data/data_src/local_data_source.dart';

class CartController extends GetxController {
  final LocalDataSource _localDataSource;
  RxMap<int, int> cartModel = RxMap<int, int>();
  RxList<ProductModel> productsInCart = RxList<ProductModel>();
  RxDouble totalPrice = 0.0.obs;
  CartController(this._localDataSource);

  Future getCart() async {
    try {
      cartModel.value = await _localDataSource.getCartData();
      productsInCart.value = await _localDataSource.getProductCartData();
      if (cartModel.length != productsInCart.length) {
        cartModel.value = {};
        productsInCart.value = [];
        await _localDataSource.deleteCartData();
        await _localDataSource.deleteProductCartData();
      }
      getTotalPrice();
    } catch (ex) {
      printError(info: '$ex');
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
      if (increase && cartModel[productData.id]! < 10) {
        cartModel[productData.id] = cartModel[productData.id]! + 1;
      } else if (!increase && cartModel[productData.id]! > 1) {
        cartModel[productData.id] = cartModel[productData.id]! - 1;
      }
      cartModel.refresh();
    } else {
      Map<int, int> dataToAdd = {
        productData.id: 1,
      };
      cartModel.addAll(dataToAdd);
      productsInCart.add(productData);
    }
    await saveCart();
    await waitStateChanged(duration: 1000);

    isLoadingCart.value = false;
    productId.value = null;
    getTotalPrice();
  }

  void deleteFromCart(ProductModel productData) async {
    isLoadingCart.value = true;
    productId.value = productData.id;

    await waitStateChanged(duration: 1000);
    await saveCart();
    cartModel.remove(productData.id);
    productsInCart.remove(productData);
    isLoadingCart.value = false;
    productId.value = null;

    getTotalPrice();
  }

  void getTotalPrice() {
    totalPrice.value = 0;
    totalPrice.value = productsInCart.fold<double>(
        0,
        (previousValue, product) =>
            previousValue +
            (cartModel[product.id]! * product.priceAfterDis != 0
                ? product.priceAfterDis * cartModel[product.id]!
                : product.price * cartModel[product.id]!));
  }
}
