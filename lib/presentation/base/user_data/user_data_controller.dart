import 'package:get/get.dart';
import 'package:ms_store/app/app_refs.dart';

import '../../../domain/models/users_model.dart';

class UserDataController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  Future getUserData() async {
    userModel.value = await AppPrefs().getUserData();
  }

  void clearData() {
    userModel.value = null;
  }
}
