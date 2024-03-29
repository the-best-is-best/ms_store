import 'package:ms_store/data/network/requests/store_requests.dart';
import 'package:ms_store/data/responses/cache/cache_server_response.dart';
import 'package:ms_store/data/responses/store_responses/favorite_response.dart';
import 'package:ms_store/data/responses/store_responses/get_products_with_pagination_response.dart';
import 'package:ms_store/data/responses/store_responses/get_products_by_ids_responses.dart';
import '../network/app_api.dart';
import '../network/requests/users_requests.dart';
import '../responses/home_response/home_response.dart';
import '../responses/store_responses/categories_responses.dart';
import '../responses/store_responses/get_category_data_by_id.dart';
import '../responses/store_responses/review/get_review_response.dart';
import '../responses/store_responses/review/update_review_response.dart';
import '../responses/users_response/response_delete_user.dart';
import '../responses/users_response/responses_forget_password.dart';
import '../responses/users_response/responses_register.dart';
import '../responses/users_response/responses_reset_password.dart';
import '../responses/users_response/responses_update_user_data.dart';
import '../responses/users_response/responses_users.dart';

abstract class RemoteDataSrc {
  Future<CacheServerResponse> getCache();

  Future<UsersResponse> login(LoginRequests loginRequests);
  Future<UsersResponse> loginBySocial(LoginBySocialRequests loginRequests);
  Future<RegisterResponse> register(RegisterRequests registerRequests);
  Future<UsersResponse> activeEmail(ActiveEmailRequests registerRequests);
  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests);
  Future<DeleteUserResponse> deleteUser(DeleteUserRequests deleteUserRequests);
  Future<ResetPasswordResponse> resetPassword(
      ResetPasswordRequests resetPasswordRequests);
  Future<HomeResponse> getHomeData();
  Future<CategoriesResponse> getCategoryData();
  Future<FavoriteAddResponse> favoriteAdd(
      AddFavoriteRequests addFavoriteRequests);
  Future<FavoriteGetResponse> getFavorite(
      GetFavoriteRequests getFavoriteRequests);
  Future<GetProductByIdsDataResponse> getProductsByIds(
      GetProductByIdsRequests getProductByIdsRequests);
  Future<GetProductByIdsDataResponse> getProductsSupplier(
      GetProductsSupplierRequests getProductsSupplierRequests);
  Future<GetReviewsDataModelResponse> getReview(
      GetReviewRequests getProductsSupplierRequests);
  Future<UpdateReviewResponse> updateReview(
      UpdateReviewRequests updateProductsSupplierRequests);
  Future<ProductWithPaginationDataResponse> getProductsByCatId(
      GetProductsByCatIdRequests getProductsByCatIdRequests);
  Future<GetCategoryDataByIdResponse> getCategoryDataById(
      GetCategoryDataByIdRequests getProductsByCatIdRequests);
  Future<ProductWithPaginationDataResponse> getProductsBySearch(
      GetProductsBySearchRequests getProductsBySearchRequests);
  Future<UpdateUserDataResponses> updateUserData(
      UpdateUserRequests updateUserRequests);
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

  @override
  Future<GetProductByIdsDataResponse> getProductsByIds(
      GetProductByIdsRequests getProductByIdsRequests) async {
    return await _appServicesClient
        .getProductsByIds(getProductByIdsRequests.ids);
  }

  @override
  Future<GetProductByIdsDataResponse> getProductsSupplier(
      GetProductsSupplierRequests getProductsSupplierRequests) async {
    return await _appServicesClient
        .getProductsSupplier(getProductsSupplierRequests.categoryId);
  }

  @override
  Future<GetReviewsDataModelResponse> getReview(
      GetReviewRequests getReviewRequests) async {
    return await _appServicesClient
        .getProductsReview(getReviewRequests.productId);
  }

  @override
  Future<UpdateReviewResponse> updateReview(
      UpdateReviewRequests updateProductsSupplierRequests) async {
    return await _appServicesClient.updateProductsReview(
        userId: updateProductsSupplierRequests.userId,
        status: updateProductsSupplierRequests.status,
        productId: updateProductsSupplierRequests.productId,
        rating: updateProductsSupplierRequests.rating,
        comment: updateProductsSupplierRequests.comment);
  }

  @override
  Future<ProductWithPaginationDataResponse> getProductsByCatId(
      GetProductsByCatIdRequests getProductsByCatIdRequests) async {
    return await _appServicesClient.getProductsByCatId(
        getProductsByCatIdRequests.catId,
        getProductsByCatIdRequests.currentPage,
        minPrice: getProductsByCatIdRequests.minPrice,
        maxPrice: getProductsByCatIdRequests.maxPrice);
  }

  @override
  Future<GetCategoryDataByIdResponse> getCategoryDataById(
      GetCategoryDataByIdRequests getCategoryDataByIdRequests) async {
    return await _appServicesClient
        .getCategoryDataById(getCategoryDataByIdRequests.catId);
  }

  @override
  Future<ProductWithPaginationDataResponse> getProductsBySearch(
      GetProductsBySearchRequests getProductsBySearchRequests) async {
    return await _appServicesClient.getProductsBySearch(
        getProductsBySearchRequests.name, getProductsBySearchRequests.lang);
  }

  @override
  Future<UpdateUserDataResponses> updateUserData(
      UpdateUserRequests updateUserRequests) async {
    return await _appServicesClient.updateUserData(
        id: updateUserRequests.id,
        password: updateUserRequests.password,
        userName: updateUserRequests.userName,
        phone: updateUserRequests.phone,
        phoneVerify: updateUserRequests.phoneVerify);
  }

  @override
  Future<DeleteUserResponse> deleteUser(
      DeleteUserRequests deleteUserRequests) async {
    return await _appServicesClient.deleteUser(deleteUserRequests.userId);
  }
}
