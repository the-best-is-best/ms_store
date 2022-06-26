class Constants {
  // api
  static const _getDataUrlPath = "get_data";
  static const _postDataUrlPath = "insert_data";
  static const _updateUrlPath = "update_data";
  static const _userControllerUrlPath = "users_controller";

  static const int timeOut = 60 * 100;
  static const String token = "";
  static const String contentType = "application/json";

  static const String baseUrl =
      "http://192.168.1.5/tbib_store_2022/large_store";

  static const String cacheUrl = '/cache/get_cache.php';

  static const String loginUrl = '/$_getDataUrlPath/get_users.php';
  static const String loginBySocialUrl =
      '/$_userControllerUrlPath/login_by_social_media.php';

  static const String registerUrl = '/$_postDataUrlPath/create_users.php';
  static const String activeEmail = '/$_userControllerUrlPath/active_email.php';

  static const String forgetPasswordUrl =
      '/$_userControllerUrlPath/forget_password.php';
  static const String resetPasswordUrl =
      '/$_userControllerUrlPath/reset_password.php';
  static const String homeUrl = '/$_getDataUrlPath/get_home_data.php';
  static const String categoryUrl = '/$_getDataUrlPath/get_category.php';

  static const String productByCatUrl =
      '/$_getDataUrlPath/get_products_by_cat.php';
  static const String addToFavorite = '/$_updateUrlPath/update_favorite.php';
  static const String getFavorite = '/$_getDataUrlPath/get_favorite.php';

  static const String getProductsByIds =
      '/$_getDataUrlPath/get_products_by_ids.php';

  static const String getProductsSupplier =
      '/$_getDataUrlPath/get_last_supplier.php';

  static const String getProductsReviews = '/$_getDataUrlPath/get_review.php';
  static const String updateProductsReviews =
      '/$_postDataUrlPath/add_review.php';

  static const String getProductsByCatId =
      '/$_getDataUrlPath/get_products_by_cat.php';

  static const String getCategoryDataById =
      '/$_getDataUrlPath/get_category_data_by_id.php';
}
