import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../core/util/get_device_type.dart';
import '../../../domain/models/store/favorite_model.dart';
import '../../main/pages/fav/view_model/fav_controller.dart';

Widget addToCartButton(int productId) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      child: Text(AppStrings.addToCartButton),
    ),
  );
}

Widget addToFavoriteButton(Function fun, int productId) {
  FavController favController = Get.find();
  print(favController.favoriteModel[productId] != null);
  bool inFav = favController.favoriteModel[productId] != null &&
      favController.favoriteModel[productId]!.status;
  print("productId: $productId - fav $inFav");
  return Positioned(
    top: 20,
    right: 20,
    child: CircleAvatar(
      radius: Device.get().isTablet ? 40 : 27,
      backgroundColor: Colors.grey[400],
      child: IconButton(
        onPressed: () {
          fun();
        },
        icon: Icon(
          inFav ? IconsManger.addedToFavorite : IconsManger.addToFavorite,
          color: inFav ? ColorManager.error : Colors.white,
          size: Device.get().isTablet ? 40 : 33.0,
        ),
      ),
    ),
  );
}
