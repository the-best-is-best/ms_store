import 'package:get/get.dart';
import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/data/network/failure.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';

import '../../../domain/models/users_model.dart';

class UserDataController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  Future getUserData() async {
    userModel.value = await AppPrefs().getUserData();
    FavController favController = Get.find();
    CartController cartController = Get.find();
    if (userModel.value != null) {
      var result =
          await favController.getFavorite(instance(), userModel.value!.id);
      result.fold((failure) {
        print(failure);
      }, (data) {
        favController.favoriteModel.addAll(data);
      });
      await cartController.getCart();
    }
  }
}
