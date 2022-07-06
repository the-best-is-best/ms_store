import '../../app/extensions.dart';
import '../../domain/models/users_model.dart';
import '../responses/users_response/responses_users.dart';

extension UsersResponseMapper on UsersResponse? {
  UserModel toDomain() {
    return UserModel(
        id: this?.data?.id.orEmpty() ?? 0,
        userName: this?.data?.userName.orEmpty() ?? "",
        email: this?.data?.email.orEmpty() ?? "",
        phone: this?.data?.phone.orEmpty() ?? "",
        phoneVerify: this?.data?.phoneVerify.orEmpty() ?? 0,
        loginBySocial: this?.data?.loginBySocial.orEmpty() ?? 0,
        tokenSocial: this?.data?.tokenSocial.orEmpty() ?? "",
        code: this?.data?.code.orEmpty() ?? "",
        password: this?.data?.password.orEmpty() ?? "");
  }
}
