class Constants {
  // api
  static const _getDataUrlPath = "get_data";
  static const _postDataUrlPath = "insert_data";
  static const _updateUrlPath = "update_data";
  static const _userControllerUrlPath = "users_controller";
  static const _deleteUrlPath = "delete";

  static const int timeOut = 60 * 100;
  static const String token = "";
  static const String contentType = "application/json";

  static const String baseUrl = "http://192.168.1.4/tbib_store_2022/adv_store";

  static const String cacheUrl = '/cache/get_cache.php';

  static const String loginUrl = '/$_getDataUrlPath/get_users.php';
  static const String loginBySocialUrl =
      '/$_userControllerUrlPath/login_by_social_media.php';

  static const String registerUrl = '/$_postDataUrlPath/create_users.php';
  static const String activeEmail = '/$_userControllerUrlPath/active_email.php';
  static const String deleteUser = '/$_deleteUrlPath/delete_user.php';

  static const String forgetPasswordUrl =
      '/$_userControllerUrlPath/forget_password.php';
  static const String resetPasswordUrl =
      '/$_userControllerUrlPath/reset_password.php';
  static const String homeUrl = '/$_getDataUrlPath/get_home_data.php';
  static const String categoryUrl = '/$_getDataUrlPath/get_category.php';

  static const String productByCatUrl =
      '/$_getDataUrlPath/get_products_by_cat.php';
  static const String addToFavoriteUrl = '/$_updateUrlPath/update_favorite.php';
  static const String getFavoriteUrl = '/$_getDataUrlPath/get_favorite.php';

  static const String getProductsByIdsUrl =
      '/$_getDataUrlPath/get_products_by_ids.php';

  static const String getProductsSupplierUrl =
      '/$_getDataUrlPath/get_last_supplier.php';

  static const String getProductsReviewsUrl =
      '/$_getDataUrlPath/get_review.php';
  static const String updateProductsReviewsUrl =
      '/$_postDataUrlPath/add_review.php';

  static const String getProductsByCatIdUrl =
      '/$_getDataUrlPath/get_products_by_cat.php';

  static const String getCategoryDataByIdUrl =
      '/$_getDataUrlPath/get_category_data_by_id.php';
  static const String aboutUrl = '/$_getDataUrlPath/get_about_us.php';
  static const String searchUrl = '/$_getDataUrlPath/search_product.php';
  static const String updateUrl = '/$_updateUrlPath/update_user.php';
  static const String createOrder = '/$_postDataUrlPath/create_order.php';

  static const String mapUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

// PayMob Api Integration
  static const String basePayMobUrl = "https://accept.paymob.com/api";

  static const String getFirstToken = '/auth/tokens';

  static const String orderRegistrationUrl = '/ecommerce/orders';

  static const String paymentKeyUrl = '/payment_keys';

  static const String payMobApiKey =
      """ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRjeE5URXpMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuUGZMcTM0SzlzeXRONTVSQ1hIaV9nSUFUZEU0bFJNbThRNnE0VGd6ZGJKVFNmcHVhQno1eGNUVEFEaUNtNnB4WmFBNl9kODQ0THZvMFdwUGswVzhkX1E=""";
  static String payMobFirstToken = "";
  static String payMobOrderId = "";

  static const String integrationIdCard = "2017540";
  static String finalTokenCard = "";

  static const String integrationIdKiosk = "2627391";
  static String finalTokenKiosk = "";

  static String refCode = "";
}
