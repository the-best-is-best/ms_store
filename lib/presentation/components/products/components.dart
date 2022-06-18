import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../core/util/get_device_type.dart';
import '../../main/pages/fav/view_model/fav_controller.dart';

Widget addToCartButton(int productId) {
  CartController _cartController = Get.find();
  return SizedBox(
    width: double.infinity,
    child: Obx(
      () {
        return BuildCondition(
          condition: _cartController.cartModel[productId] == null ||
              _cartController.cartModel[productId]?.quantity == 0,
          builder: (_) => ElevatedButton(
            onPressed: () {
              _cartController.addToCart(productId, false);
            },
            child: Text(AppStrings.addToCartButton),
          ),
          fallback: (_) =>
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CircleAvatar(
              backgroundColor: ColorManager.white,
              child: IconButton(
                icon: Icon(
                  IconsManger.minus,
                  size: AppSize.ap30.sp,
                ),
                onPressed: () {
                  _cartController.addToCart(productId, false);
                },
              ),
            ),
            CircleAvatar(
                backgroundColor: ColorManager.white,
                child: Builder(builder: (context) {
                  return Text(
                      _cartController.cartModel[productId]!.quantity.toString(),
                      style: context.textTheme.labelMedium!
                          .copyWith(color: ColorManager.darkColor));
                })),
            CircleAvatar(
              backgroundColor: ColorManager.white,
              child: IconButton(
                icon: Icon(
                  IconsManger.plus,
                  size: AppSize.ap30.sp,
                ),
                onPressed: () {
                  _cartController.addToCart(productId, true);
                },
              ),
            ),
          ]),
        );
      },
    ),
  );
}

Widget addToFavoriteButton(Function fun, int productId) {
  FavController _favController = Get.find();
  bool inFav = _favController.favoriteModel[productId] != null &&
      _favController.favoriteModel[productId]!.status;
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
              style: context.textTheme.labelMedium!
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
              style: context.textTheme.labelMedium!
                  .copyWith(color: ColorManager.darkColor),
            ),
          ),
          Expanded(
            child: Text(
              '${productModel.price} EG',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall!.copyWith(
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
