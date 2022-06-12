import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests/users_requests.dart';
import '../models/home_models/home_data_model.dart';
import '../models/store/category_model.dart';
import '../models/users_model.dart';

abstract class Repository {
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
}
