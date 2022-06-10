import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../data/data_src/remote_data_src.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_manager.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/use_case/home_use_case.dart';
import '../domain/use_case/users_case/active_email_case.dart';
import '../domain/use_case/users_case/forget_password_case.dart';
import '../domain/use_case/users_case/login_use_case.dart';
import '../domain/use_case/users_case/register_use_case.dart';
import '../domain/use_case/users_case/reset_password_case.dart';
import 'app_refs.dart';

final instance = GetIt.instance;
late final Box onBoarding;

late final Box settings;

Future<void> initAppModel() async {
  DioManger.init();

  await Hive.initFlutter();
  settings = await Hive.openBox(AppPrefs.settings);
  onBoarding = await Hive.openBox(AppPrefs.onBoarding);
  //Hive.registerAdapter(UserModelAdapter());

  // network info

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

// AppServicesClient
  instance.registerLazySingleton<AppServicesClient>(
      () => AppServicesClient(DioManger.dioApi));
//  remote Data Source

  instance.registerLazySingleton<RemoteDataSrc>(
      () => RemoteDataSrcImpl(instance()));

//    repositry

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
//   //instance.registerLazySingleton(() => I10n());
}

void initLoginModel() {
  if (!GetIt.I.isRegistered<LoginUserCase>()) {
    instance.registerFactory<LoginUserCase>(() => LoginUserCase(instance()));
  }
}

void initHomeModel() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
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
