import 'package:get/get.dart';
import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';

import '../../../domain/models/users_model.dart';

class UserDataController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  @override
  void onInit() async {
    userModel.value = await AppPrefs().getUserData();
    FavController favController = Get.find();
    await favController.getFavorite();
    super.onInit();
  }
}
