import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/data/data_src/local_data_source.dart';
import 'package:ms_store/domain/models/cache/cache_data.dart';
import 'package:ms_store/domain/models/home_models/slider_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/domain/use_case/store/category_use_case.dart';
import 'package:ms_store/domain/use_case/users_case/login_social_use_case.dart';
import 'package:ms_store/presentation/main/pages/settings/view_model/settings_controller.dart';

import '../data/data_src/remote_data_src.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_manager.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/models/home_models/category_home_model.dart';
import '../domain/models/home_models/data_home_model.dart';
import '../domain/models/home_models/home_data_model.dart';
import '../domain/models/home_models/product_home_model.dart';
import '../domain/models/store/category_model.dart';
import '../domain/models/store/product_model.dart';
import '../domain/models/users_model.dart';
import '../domain/repository/repository.dart';
import '../domain/use_case/home_use_case.dart';
import '../domain/use_case/store/add_favorite_use_case.dart';
import '../domain/use_case/users_case/active_email_case.dart';
import '../domain/use_case/users_case/forget_password_case.dart';
import '../domain/use_case/users_case/login_use_case.dart';
import '../domain/use_case/users_case/register_use_case.dart';
import '../domain/use_case/users_case/reset_password_case.dart';

final instance = GetIt.instance;

Future<void> initAppModel() async {
  DioManger.init();

  await Hive.initFlutter();
  //user
  Hive.registerAdapter(UserModelAdapter());
  //home
  Hive.registerAdapter(HomeModelAdapter());
  Hive.registerAdapter(HomeDataModelAdapter());
  Hive.registerAdapter(SliderModelAdapter());
  Hive.registerAdapter(CategoryHomeModelAdapter());
  Hive.registerAdapter(ProductHomeModelAdapter());
  Hive.registerAdapter(DataHomeModelAdapter());
  //category
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CachedDataAdapter());

  // network info

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

// AppServicesClient
  instance.registerLazySingleton<AppServicesClient>(
      () => AppServicesClient(DioManger.dioApi));
//  remote Data Source

  instance.registerLazySingleton<RemoteDataSrc>(
      () => RemoteDataSrcImpl(instance()));

// local Data Source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
//    repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
//   //instance.registerLazySingleton(() => I10n());
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
