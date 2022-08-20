import 'package:dio/dio.dart';
import '../../app/resources/strings_manager.dart';
import 'error_handler.dart';
import 'failure.dart';

Failure responseError(DioError error) {
  if (error.response != null &&
      error.response?.statusCode != null &&
      error.response?.data['messages'] != null &&
      ((error.response?.data['messages']) as List).isNotEmpty) {
    if (error.response?.data['messages'][0] == "Check your email or password") {
      return Failure(error.response?.statusCode ?? 500,
          AppStrings.checkYourEmailOrPassword);
    } else if (error.response?.data['messages'][0] == "Email Not Found") {
      return Failure(error.response?.statusCode ?? 0, AppStrings.emailNotFound);
    } else if (error.response?.data['messages'][0] == "Email Not Found") {
      return Failure(error.response?.statusCode ?? 0, AppStrings.emailNotFound);
    } else if (error.response?.data['messages'][0] == "Email already exists") {
      return Failure(error.response?.statusCode ?? 0, AppStrings.emailExist);
    } else {
      return DataRes.DEFAULT.getFailure();
    }
  } else {
    return DataRes.DEFAULT.getFailure();
  }
}
