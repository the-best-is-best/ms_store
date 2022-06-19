import 'package:dartz/dartz.dart';
import 'package:ms_store/domain/models/cache/cache_data.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests/favorites_requests.dart';
import '../../data/network/requests/users_requests.dart';
import '../models/home_models/home_data_model.dart';
import '../models/store/category_model.dart';
import '../models/users_model.dart';

abstract class Repository {
  Future<Either<Failure, CheckCachedDataServer>> cache();

  Future<Either<Failure, UserModel>> login(LoginRequests loginRequests);
  Future<Either<Failure, UserModel>> loginBySocial(
      LoginBySocialRequests loginRequests);
  Future<Either<Failure, bool>> register(RegisterRequests registerRequests);
  Future<Either<Failure, UserModel>> activeEmail(
      ActiveEmailRequests activeEmailRequests);
  Future<Either<Failure, bool>> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests);
  Future<Either<Failure, bool>> resetPassword(
      ResetPasswordRequests resetPasswordRequests);
  Future<Either<Failure, HomeModel>> getHomeData();
  Future<Either<Failure, CategoryModel>> getCategoryData();
  Future<Either<Failure, bool>> addProductToFavorite(
      AddFavoriteRequests addFavoriteRequests);
  Future<Either<Failure, Map<int, bool>>> getProductToFavorite(
      GetFavoriteRequests getFavoriteRequests);
//   Future<Either<Failure, List<ProductModel>>> getProductByIds(
//       GetProductsDetailsCartUseCaseInput getProductByIds);
}
