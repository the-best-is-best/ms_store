import 'package:get/get.dart';
import 'package:ms_store/core/resources/routes_manger.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

void goToProductDetails(ProductModel product) {
  Get.toNamed(Routes.productDetailsRoute, arguments: {'product': product});
}
