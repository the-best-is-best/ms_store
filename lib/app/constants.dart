class Constants {
  // api

  static const int timeOut = 60 * 100;
  static const String token = "";
  static const String contentType = "application/json";

  static const String baseUrl =
      "http://192.168.1.6/tbib_store_2022/large_store";

  static const String cacheUrl = '/cache/get_cache.php';

  static const String loginUrl = '/get_data/get_users.php';
  static const String loginBySocialUrl =
      '/users_controller/login_by_social_media.php';

  static const String registerUrl = '/insert_data/create_users.php';
  static const String activeEmail = '/users_controller/active_email.php';

  static const String forgetPasswordUrl =
      '/users_controller/forget_password.php';
  static const String resetPasswordUrl = '/users_controller/reset_password.php';
  static const String homeUrl = '/get_data/get_home_data.php';
  static const String categoryUrl = '/get_data/get_category.php';

  static const String productByCatUrl = '/get_data/get_products_by_cat.php';
  static const String addToFavorite = '/update_data/update_favorite.php';
  static const String getFavorite = '/get_data/get_favorite.php';
}
