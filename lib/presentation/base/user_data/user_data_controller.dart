import 'package:get/get.dart';

import '../../../domain/models/users_model.dart';

class UserDataController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  void loadData(data) async {
    userModel.value = data;
    super.onInit();
  }
}
