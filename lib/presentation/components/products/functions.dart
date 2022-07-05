import 'package:get/get.dart';
import 'package:ms_store/app/resources/routes_manger.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

import '../../../app/di.dart';

void goToProductDetails(ProductModel product) {
  initProductDetailsModel();
  Get.toNamed(Routes.productDetailsRoute, arguments: {'product': product});
}

// void openProductFromProductDetails(ProductModel product) {
//   Get.offAndToNamed(Routes.productDetailsRoute,
//       arguments: {'product': product});
// }
