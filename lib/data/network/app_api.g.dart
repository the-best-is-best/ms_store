// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _AppServicesClient implements AppServicesClient {
  _AppServicesClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.1.6/tbib_store_2022/large_store';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CacheServerResponse> cache() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CacheServerResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/cache/get_cache.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CacheServerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UsersResponse> login(email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'email': email,
      r'password': password
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UsersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_users.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UsersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UsersResponse> loginBySocial(
      {required email,
      required userName,
      required tokenSocial,
      required loginBySocial}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'userName': userName,
      'tokenSocial': tokenSocial,
      'loginBySocial': loginBySocial
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UsersResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/users_controller/login_by_social_media.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UsersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResponse> register(
      {required email, required password, required userName}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'password': password, 'userName': userName};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/insert_data/create_users.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UsersResponse> activeEmail({required email, required pin}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'pin': pin};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UsersResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users_controller/active_email.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UsersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgetPasswordResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users_controller/forget_password.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgetPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      {required pin, required email, required password}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'pin': pin, 'email': email, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ResetPasswordResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users_controller/reset_password.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ResetPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HomeResponse> getHomeData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HomeResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_home_data.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HomeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoriesResponse> getCategoryData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoriesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_category.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoriesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteAddResponse> addToFavorite(userId, productId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'userId': userId, 'productId': productId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteAddResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/update_data/update_favorite.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteAddResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FavoriteGetResponse> getFavorite(userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'userId': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteGetResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_favorite.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FavoriteGetResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetProductByIdsDataResponse> getProductsByIds(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': id};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetProductByIdsDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_products_by_ids.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetProductByIdsDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetProductByIdsDataResponse> getProductsSupplier(categoryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'categoryId': categoryId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetProductByIdsDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_last_supplier.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetProductByIdsDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetReviewsDataModelResponse> getProductsReview(productId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'productId': productId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetReviewsDataModelResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_review.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetReviewsDataModelResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateReviewResponse> updateProductsReview(
      {required userId,
      required status,
      required productId,
      required rating,
      required comment}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'userId': userId,
      'status': status,
      'productId': productId,
      'rating': rating,
      'comment': comment
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/insert_data/add_review.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductWithPaginationDataResponse> getProductsByCatId(catId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'catId': catId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductWithPaginationDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_products_by_cat.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProductWithPaginationDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCategoryDataByIdResponse> getCategoryDataById(catId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'catId': catId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCategoryDataByIdResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_category_data_by_id.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCategoryDataByIdResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAboutDataResponse> getAbout() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAboutDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/get_about_us.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAboutDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProductWithPaginationDataResponse> getProductsBySearch(
      name, lang) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'name': name, r'lang': lang};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProductWithPaginationDataResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/get_data/search_product.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProductWithPaginationDataResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
