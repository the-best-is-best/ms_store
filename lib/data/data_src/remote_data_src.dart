import '../network/app_api.dart';
import '../network/requests/users_requests.dart';
import '../responses/home_response/home_response.dart';
import '../responses/store_responses/categories_responses.dart';
import '../responses/users_response/responses_forget_password.dart';
import '../responses/users_response/responses_register.dart';
import '../responses/users_response/responses_reset_password.dart';
import '../responses/users_response/responses_users.dart';

abstract class RemoteDataSrc {
  Future<UsersResponse> login(LoginRequests loginRequests);
  Future<UsersResponse> loginBySocial(LoginBySocialRequests loginRequests);
  Future<RegisterResponse> register(RegisterRequests registerRequests);
  Future<UsersResponse> activeEmail(ActiveEmailRequests registerRequests);
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests);
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequests resetPasswordRequests);
  Future<CategoriesResponse> getCategoryData();
  Future<HomeResponse> getHomeData();
}

class RemoteDataSrcImpl implements RemoteDataSrc {
  final AppServicesClient _appServicesClient;
  RemoteDataSrcImpl(this._appServicesClient);

  @override
  Future<UsersResponse> login(LoginRequests loginRequests) async {
    return await _appServicesClient.login(
        loginRequests.email, loginRequests.password);
  }

  @override
  Future<UsersResponse> loginBySocial(
      LoginBySocialRequests loginRequests) async {
    return await _appServicesClient.loginBySocial(
        email: loginRequests.email,
        loginBySocial: loginRequests.loginBySocial,
        tokenSocial: loginRequests.tokenSocial,
        userName: loginRequests.userName);
  }

  @override
  Future<RegisterResponse> register(RegisterRequests registerRequests) async {
    return await _appServicesClient.register(
      email: registerRequests.email,
      password: registerRequests.password,
      userName: registerRequests.userName,
    );
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests) async {
    return await _appServicesClient
        .forgetPassword(forgetPasswordRequests.email);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequests resetPasswordRequests) async {
    return await _appServicesClient.resetPassword(
        email: resetPasswordRequests.email,
        pin: resetPasswordRequests.pin,
        password: resetPasswordRequests.password);
  }

  @override
  Future<UsersResponse> activeEmail(
      ActiveEmailRequests activeEmailRequests) async {
    return await _appServicesClient.activeEmail(
        email: activeEmailRequests.email, pin: activeEmailRequests.pin);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServicesClient.getHomeData();
  }

  @override
  Future<CategoriesResponse> getCategoryData() async {
    return await _appServicesClient.getCategoryData();
  }
}
