import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../core/util/get_device_type.dart';
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
  bool inFav = favController.favoriteModel[productId] != null &&
      favController.favoriteModel[productId]!.status;
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

Widget buildPrice(ProductModel productModel) {
  return Builder(builder: (context) {
    return BuildCondition(
      condition: productModel.priceAfterDis == 0.0,
      builder: (context) {
        return Row(
          children: [
            Text(
              '${productModel.price} EG',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.getThemeDataText.labelMedium!
                  .copyWith(color: ColorManager.darkColor),
            ),
          ],
        );
      },
      fallback: (_) => Row(
        children: [
          Expanded(
            child: Text(
              '${productModel.priceAfterDis} EG',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.getThemeDataText.labelMedium!
                  .copyWith(color: ColorManager.darkColor),
            ),
          ),
          Expanded(
            child: Text(
              '${productModel.price} EG',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.getThemeDataText.labelSmall!.copyWith(
                color: ColorManager.darkColor,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  });
}
