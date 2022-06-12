import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../app/constants.dart';
import '../responses/home_response/home_response.dart';
import '../responses/store_responses/categories_responses.dart';
import '../responses/users_response/responses_forget_password.dart';
import '../responses/users_response/responses_register.dart';
import '../responses/users_response/responses_reset_password.dart';
import '../responses/users_response/responses_users.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) =
      _AppServicesClient; // factory

// users api
//login by email and pass
  @GET(Constants.loginUrl)
  Future<UsersResponse> login(
      @Query("email") String email, @Query("password") String password);
  @POST(Constants.loginBySocialUrl)
  Future<UsersResponse> loginBySocial({
    @Field("email") required String email,
    @Field("userName") required String userName,
    @Field("tokenSocial") required String tokenSocial,
    @Field("loginBySocial") required int loginBySocial,
  });
  @POST(Constants.registerUrl)
  Future<RegisterResponse> register({
    @Field("email") required String email,
    @Field("password") required String password,
    @Field("userName") required String userName,
  });
  @POST(Constants.activeEmail)
  Future<UsersResponse> activeEmail({
    @Field("email") required String email,
    @Field("pin") required String pin,
  });
  @POST(Constants.forgetPasswordUrl)
  Future<ForgetPasswordResponse> forgetPassword(@Field("email") String email);
  @POST(Constants.resetPasswordUrl)
  Future<ResetPasswordResponse> resetPassword(
      {@Field("pin") required String pin,
      @Field("email") required String email,
      @Field("password") required String password});
  @GET(Constants.categoryUrl)
  Future<CategoriesResponse> getCategoryData();
  @GET(Constants.homeUrl)
  Future<HomeResponse> getHomeData();
}
