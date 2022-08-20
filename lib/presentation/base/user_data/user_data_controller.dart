import 'package:get/get.dart';
import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/domain/use_case/users_case/login_social_use_case.dart';
import '../../../domain/models/users_model.dart';

class UserDataController extends GetxController {
  final LoginBySocialUserCase _loginBySocialUserCase;
  UserDataController(this._loginBySocialUserCase);

  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  Future getUserData() async {
    userModel.value = await AppPrefs().getUserData();
  }

  void checkUserCache() async {
    UserModel? cacheUser = await AppPrefs().getUserData();
    if (cacheUser != null) {
      if (cacheUser.loginBySocial != 0) {
        var result = await _loginBySocialUserCase.execute(
            LoginBySocialUserCaseInput(
                email: cacheUser.email,
                loginBySocial: cacheUser.loginBySocial,
                tokenSocial: cacheUser.tokenSocial,
                userName: cacheUser.userName));
        result.fold((failure) {}, (data) async {
          userModel.value = data;
          if (cacheUser.email != data.email) {
            await AppPrefs().updateUserData(data);
          }
        });
      }
    }
  }

  void clearData() {
    userModel.value = null;
  }
}
