import 'package:ms_store/data/data_src/local_data_source.dart';
import 'package:ms_store/data/network/requests/store_requests.dart';
import 'package:ms_store/data/repository/store/repository_impl_add_favorite.dart';
import 'package:ms_store/data/repository/store/repository_impl_get_favorite.dart';
import 'package:ms_store/data/repository/store/repository_impl_get_product_by_cat_id.dart';
import 'package:ms_store/data/repository/store/repository_impl_get_products_by_ids.dart';
import 'package:ms_store/data/repository/store/repository_impl_get_products_by_search.dart';
import 'package:ms_store/data/repository/users_repository/repository_impl_login_by_social.dart';
import 'package:ms_store/domain/models/cache/cache_data.dart';
import 'package:ms_store/domain/models/store/product_with_pagination_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/models/store/reviews_model.dart';
import '../../domain/models/home_models/home_data_model.dart';
import '../../domain/models/store/category_model.dart';
import 'cache/repository_impl_cache_data_server.dart';
import 'home_data_repository.dart';
import 'store/repository_impl_category.dart';
import 'store/repository_impl_get_category_data_by_id.dart';
import 'store/repository_impl_get_products_supplier.dart';
import 'store/review/repository_impl_get_review.dart';
import 'store/review/repository_impl_update_review.dart';
import 'users_repository/repository_impl_active_email.dart';
import 'users_repository/repository_impl_register.dart';
import 'users_repository/repository_impl_login.dart';
import 'users_repository/repository_impl_reset_password.dart';
import '../data_src/remote_data_src.dart';
import '../network/network_info.dart';
import '../../domain/models/users_model.dart';
import '../network/requests/users_requests.dart';
import '../network/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';

import 'users_repository/repository_impl_forget_password.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSrc _remoteDataSrc;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._remoteDataSrc, this._networkInfo, this._localDataSource);
  @override
  Future<Either<Failure, CheckCachedDataServer>> cache() async {
    return await RepositoryImplCacheDataServer.call(
        _remoteDataSrc, _networkInfo);
  }

  @override
  Future<Either<Failure, bool>> register(
      RegisterRequests registerRequests) async {
    return await RepositoryImplRegister.call(
        _remoteDataSrc, _networkInfo, registerRequests);
  }

  @override
  Future<Either<Failure, UserModel>> login(LoginRequests loginRequests) async {
    return await RepositoryImplLogin.call(
        _remoteDataSrc, _networkInfo, loginRequests);
  }

  @override
  Future<Either<Failure, UserModel>> loginBySocial(
      LoginBySocialRequests loginRequests) async {
    return await RepositoryImplLoginBySocial.call(
        _remoteDataSrc, _networkInfo, loginRequests);
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests) async {
    return await RepositoryImplForgetPassword.call(
        _remoteDataSrc, _networkInfo, forgetPasswordRequests);
  }

  @override
  Future<Either<Failure, bool>> resetPassword(
      ResetPasswordRequests resetPasswordRequests) async {
    return await RepositoryImplResetPassword.call(
        _remoteDataSrc, _networkInfo, resetPasswordRequests);
  }

  @override
  Future<Either<Failure, UserModel>> activeEmail(
      ActiveEmailRequests activeEmailRequests) async {
    return await RepositoryImplActiveEmail.call(
        _remoteDataSrc, _networkInfo, activeEmailRequests);
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    return await RepositoryImpGetHomeData.call(
        _remoteDataSrc, _networkInfo, _localDataSource);
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategoryData() async {
    return await RepositoryImplCategory.call(
        _remoteDataSrc, _networkInfo, _localDataSource);
  }

  @override
  Future<Either<Failure, bool>> addProductToFavorite(
      AddFavoriteRequests addFavoriteRequests) async {
    return await RepositoryImplAddFavorite.call(
        _remoteDataSrc, _networkInfo, addFavoriteRequests);
  }

  @override
  Future<Either<Failure, Map<int, bool>>> getProductToFavorite(
      GetFavoriteRequests getFavoriteRequests) async {
    return await RepositoryImplGetFavorite.call(
        _remoteDataSrc, _networkInfo, _localDataSource, getFavoriteRequests);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductByIds(
      GetProductByIdsRequests getProductByIds) async {
    return await RepositoryImplGetProductsByIds.call(
        _remoteDataSrc, _networkInfo, getProductByIds, _localDataSource);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsSupplier(
      GetProductsSupplierRequests getProductsSupplierRequests) async {
    return await RepositoryImplGetProductsSupplier.call(
        _remoteDataSrc, _networkInfo, getProductsSupplierRequests);
  }

  @override
  Future<Either<Failure, ReviewsModel>> getReview(
      GetReviewRequests getReviewRequests) async {
    return await RepositoryImplGetReviewRequests.call(
        _remoteDataSrc, _networkInfo, getReviewRequests);
  }

  @override
  Future<Either<Failure, bool>> updateReview(
      UpdateReviewRequests updateReviewRequests) async {
    return await RepositoryImplUpdateReviewRequests.call(
        _remoteDataSrc, _networkInfo, updateReviewRequests);
  }

  @override
  Future<Either<Failure, ProductWithPaginationModel>> getProductsByCatId(
      GetProductsByCatIdRequests getProductsByCatIdRequests) async {
    return await RepositoryImplGetProductByCatId.call(
        _remoteDataSrc, _networkInfo, getProductsByCatIdRequests);
  }

  @override
  Future<Either<Failure, CategoryDataModel>> getCategoryDataById(
      GetCategoryDataByIdRequests getCategoryDataByIdRequests) async {
    return await RepositoryImplGetCategoryDataById.call(
        _remoteDataSrc, _networkInfo, getCategoryDataByIdRequests);
  }

  @override
  Future<Either<Failure, ProductWithPaginationModel>> getProductBySearch(
      GetProductsBySearchRequests getCategoryDataByIdRequests) async {
    return await RepositoryImplGetProductsBySearch.call(
        _remoteDataSrc, _networkInfo, getCategoryDataByIdRequests);
  }
}
