import '../../domain/models/home_models/home_data_model.dart';
import '../../domain/models/store/category_model.dart';
import 'home_data_repository.dart';
import 'store/repository_impl_category.dart';
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

  RepositoryImpl(this._remoteDataSrc, this._networkInfo);
  @override
  Future<Either<Failure, bool>> register(RegisterRequests registerRequests) {
    return RepositoryImplRegister.call(
        _remoteDataSrc, _networkInfo, registerRequests);
  }

  @override
  Future<Either<Failure, UserModel>> login(LoginRequests loginRequests) async {
    return RepositoryImplLogin.call(
        _remoteDataSrc, _networkInfo, loginRequests);
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(
      ForgetPasswordRequests forgetPasswordRequests) {
    return RepositoryImplForgetPassword.call(
        _remoteDataSrc, _networkInfo, forgetPasswordRequests);
  }

  @override
  Future<Either<Failure, bool>> resetPassword(
      ResetPasswordRequests resetPasswordRequests) {
    return RepositoryImplResetPassword.call(
        _remoteDataSrc, _networkInfo, resetPasswordRequests);
  }

  @override
  Future<Either<Failure, UserModel>> activeEmail(
      ActiveEmailRequests activeEmailRequests) {
    return RepositoryImplActiveEmail.call(
        _remoteDataSrc, _networkInfo, activeEmailRequests);
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData() {
    return RepositoryImpGetHomeData.call(_remoteDataSrc, _networkInfo);
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategoryData() {
    return RepositoryImplCategory.call(_remoteDataSrc, _networkInfo);
  }
}
