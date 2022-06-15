import 'package:ms_store/data/network/requests/favorites_requests.dart';
import 'package:ms_store/data/responses/cache/cache_server_response.dart';
import 'package:ms_store/data/responses/store_responses/favorite_response.dart';
import 'package:ms_store/domain/models/cache/cache_data.dart';

import '../network/app_api.dart';
import '../network/requests/users_requests.dart';
import '../responses/home_response/home_response.dart';
import '../responses/store_responses/categories_responses.dart';
import '../responses/users_response/responses_forget_password.dart';
import '../responses/users_response/responses_register.dart';
import '../responses/users_response/responses_reset_password.dart';
import '../responses/users_response/responses_users.dart';

abstract class RemoteDataSrc {
  Future<CacheServerResponse> getCache();

  Future<UsersResponse> login(LoginRequests loginRequests);
  Future<UsersResponse> loginBySocial(LoginBySocialRequests loginRequests);
  Future<RegisterResponse> register(RegisterRequests registerRequests);
  Future<UsersResponse> activeEmail(ActiveEmailRequests registerRequests);
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests);
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequests resetPasswordRequests);
  Future<HomeResponse> getHomeData();
  Future<CategoriesResponse> getCategoryData();
  Future<FavoriteAddResponse> favoriteAdd(
      AddFavoriteRequests addFavoriteRequests);
  Future<FavoriteGetResponse> getFavorite(
      GetFavoriteRequests getFavoriteRequests);
}

class RemoteDataSrcImpl implements RemoteDataSrc {
  final AppServicesClient _appServicesClient;
  RemoteDataSrcImpl(this._appServicesClient);
  @override
  Future<CacheServerResponse> getCache() async {
    return await _appServicesClient.cache();
  }

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

  @override
  Future<FavoriteAddResponse> favoriteAdd(
      AddFavoriteRequests addFavoriteRequests) async {
    return await _appServicesClient.addToFavorite(
        addFavoriteRequests.userId, addFavoriteRequests.productId);
  }

  @override
  Future<FavoriteGetResponse> getFavorite(
      GetFavoriteRequests getFavoriteRequests) async {
    return await _appServicesClient.getFavorite(getFavoriteRequests.userId);
  }
}
