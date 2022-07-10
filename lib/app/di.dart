import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ms_store/data/data_src/local_data_source.dart';
import 'package:ms_store/domain/use_case/cache/cache_use_case.dart';
import 'package:ms_store/domain/use_case/store/category_use_case.dart';
import 'package:ms_store/domain/use_case/store/get_product_by_cat_id_use_case.dart';
import 'package:ms_store/domain/use_case/store/get_products_by_ids_use_case.dart';
import 'package:ms_store/domain/use_case/store/review/get_review_use_case.dart';
import 'package:ms_store/domain/use_case/users_case/login_social_use_case.dart';
import 'package:ms_store/domain/use_case/users_case/update_user_data_case.dart';

import '../data/data_src/remote_data_src.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_manager.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/use_case/home_use_case.dart';
import '../domain/use_case/store/add_favorite_use_case.dart';
import '../domain/use_case/store/get_category_data_by_id_use_case.dart';
import '../domain/use_case/store/get_favorite_use_case.dart';
import '../domain/use_case/store/get_products_by_search_use_case.dart';
import '../domain/use_case/store/get_products_supplier_use_case.dart';
import '../domain/use_case/store/review/update_review_use_case.dart';
import '../domain/use_case/users_case/active_email_case.dart';
import '../domain/use_case/users_case/forget_password_case.dart';
import '../domain/use_case/users_case/login_use_case.dart';
import '../domain/use_case/users_case/register_use_case.dart';
import '../domain/use_case/users_case/reset_password_case.dart';
import '../presentation/checkout/repository/repository_map.dart';

final instance = GetIt.instance;

void initAppModel() {
  DioManger.init();
  instance
      .registerLazySingleton<CacheUserCase>(() => CacheUserCase(instance()));
  // network info

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

// AppServicesClient
  instance.registerLazySingleton<AppServicesClient>(
      () => AppServicesClient(DioManger.dioApi));
//  remote Data Source

// local Data Source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
//    repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
//
  instance.registerLazySingleton<RemoteDataSrc>(
      () => RemoteDataSrcImpl(instance()));
  instance.registerLazySingleton<GetProductByIdUseCase>(
      () => GetProductByIdUseCase(instance()));
}

void initLoginModel() {
  if (!GetIt.I.isRegistered<LoginUserCase>()) {
    instance.registerFactory<LoginUserCase>(() => LoginUserCase(instance()));
    instance.registerFactory<LoginBySocialUserCase>(
        () => LoginBySocialUserCase(instance()));
  }
}

Future initHomeModel() async {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance
        .registerFactory<CategoryUseCase>(() => CategoryUseCase(instance()));
    instance.registerFactory<AddFavoriteUseCase>(
        () => AddFavoriteUseCase(instance()));
    instance.registerFactory<GetFavoriteUseCase>(
        () => GetFavoriteUseCase(instance()));

    instance.registerFactory(() => GetCategoryDataByIdUseCase(instance()));
  }
}

void initRegisterModel() {
  if (!GetIt.I.isRegistered<RegisterUserCase>()) {
    instance
        .registerFactory<RegisterUserCase>(() => RegisterUserCase(instance()));
  }
}

void initForgetPasswordModel() {
  if (!GetIt.I.isRegistered<ForgetPasswordCase>()) {
    instance.registerFactory<ForgetPasswordCase>(
        () => ForgetPasswordCase(instance()));
  }
}

void initResetPasswordModel() {
  if (!GetIt.I.isRegistered<ResetPasswordCase>()) {
    instance.registerFactory<ResetPasswordCase>(
        () => ResetPasswordCase(instance()));
  }
}

void initActiveEmailModel() {
  if (!GetIt.I.isRegistered<ActiveEmailCase>()) {
    instance
        .registerFactory<ActiveEmailCase>(() => ActiveEmailCase(instance()));
  }
}

void initProductDetailsModel() {
  if (!GetIt.I.isRegistered<GetProductSupplierUseCase>()) {
    instance.registerFactory<GetProductSupplierUseCase>(
        () => GetProductSupplierUseCase(instance()));
    instance
        .registerFactory<GetReviewUseCase>(() => GetReviewUseCase(instance()));
    instance.registerFactory<UpdateReviewUseCase>(
        () => UpdateReviewUseCase(instance()));
  }
}

void initProductByCatId() {
  if (!GetIt.I.isRegistered<GetProductByCatIdUseCase>()) {
    instance.registerFactory<GetProductByCatIdUseCase>(
        () => GetProductByCatIdUseCase(instance()));
  }
}

void initProductBySearch() {
  if (!GetIt.I.isRegistered<GetProductsBySearchUseCase>()) {
    instance.registerFactory<GetProductsBySearchUseCase>(
        () => GetProductsBySearchUseCase(instance()));
  }
}

void initUpdateProfile() {
  if (!GetIt.I.isRegistered<UpdateUserDataUserCase>()) {
    instance.registerFactory<UpdateUserDataUserCase>(
        () => UpdateUserDataUserCase(instance()));
  }
}

void initDirectionRepository() {
  if (!GetIt.I.isRegistered<DirectionsRepository>()) {
    instance
        .registerFactory<DirectionsRepository>(() => DirectionsRepository());
  }
}
