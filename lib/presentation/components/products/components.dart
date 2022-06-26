import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:ms_store/presentation/products_views/details/controller/product_details_controller.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../core/util/get_device_type.dart';
import '../../main/pages/fav/view_model/fav_controller.dart';

class AddToCartButton extends StatefulWidget {
  final ProductModel product;
  final Color circleColor;
  const AddToCartButton(this.product, this.circleColor, {Key? key})
      : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  late final CartController _cartController;
  @override
  void initState() {
    _cartController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BuildCondition(
        condition: _cartController.cartModel[widget.product.id] == null ||
            _cartController.cartModel[widget.product.id] == 0,
        builder: (_) => ElevatedButton(
          onPressed: () async {
            _cartController.addToCart(widget.product, false);
          },
          child: Text(
            AppStrings.addToCartButton,
          ),
        ),
        fallback: (_) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CircleAvatar(
            backgroundColor: widget.circleColor,
            child: Obx(() => IconButton(
                  icon: Icon(
                    IconsManger.minus,
                    size: AppSize.ap30.sp,
                  ),
                  onPressed: _cartController.productId.value != null
                      ? null
                      : () {
                          _cartController.addToCart(widget.product, false);
                        },
                )),
          ),
          CircleAvatar(
            backgroundColor: widget.circleColor,
            child: Obx(
              () => BuildCondition(
                condition: _cartController.productId.value == null ||
                    _cartController.productId.value != widget.product.id,
                builder: (_) => Text(
                    _cartController.cartModel[widget.product.id]!.toString(),
                    style: context.textTheme.labelMedium!
                        .copyWith(color: ColorManager.darkColor)),
                fallback: (_) => Center(
                  child: buildCircularProgressIndicator(),
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: widget.circleColor,
            child: Obx(() => IconButton(
                  icon: Icon(
                    IconsManger.plus,
                    size: AppSize.ap30.sp,
                  ),
                  onPressed: _cartController.productId.value != null
                      ? null
                      : () {
                          _cartController.addToCart(widget.product, true);
                        },
                )),
          ),
        ]),
      );
    });
  }
}

class AddToFavoriteButton extends StatefulWidget {
  final ProductModel product;
  const AddToFavoriteButton({Key? key, required this.product})
      : super(key: key);

  @override
  State<AddToFavoriteButton> createState() => _AddToFavoriteButtonState();
}

class _AddToFavoriteButtonState extends State<AddToFavoriteButton> {
  late final FavController _favController;
  late bool inFav;
  @override
  void initState() {
    _favController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: Device.get().isTablet ? 40 : 20,
        backgroundColor: Colors.grey[400],
        child: Obx(() => BuildCondition(
              condition: _favController.productId.value != widget.product.id,
              builder: (context) {
                return IconButton(
                  onPressed: _favController.productId.value != null
                      ? null
                      : () {
                          _favController.addToFavoriteEvent(widget.product);
                        },
                  icon: Builder(builder: (context) {
                    inFav =
                        _favController.favoriteModel[widget.product.id] == true;

                    return Icon(
                      inFav
                          ? IconsManger.addedToFavorite
                          : IconsManger.addToFavorite,
                      color: inFav ? ColorManager.error : Colors.white,
                      size: Device.get().isTablet ? 40 : 25.0,
                    );
                  }),
                );
              },
              fallback: (_) => Center(child: buildCircularProgressIndicator()),
            )));
  }
}

Widget buildPrice(ProductModel productModel, {bool detailsPage = false}) {
  return Builder(builder: (context) {
    return BuildCondition(
      condition: productModel.priceAfterDis == 0.0,
      builder: (context) {
        return Row(
          children: [
            Text(
              '${productModel.price} EG',
              style: context.textTheme.labelMedium!
                  .copyWith(color: ColorManager.darkColor),
            ),
          ],
        );
      },
      fallback: (_) => BuildCondition(
        condition: !detailsPage,
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${productModel.priceAfterDis} EG',
                style: context.textTheme.labelMedium!
                    .copyWith(color: ColorManager.darkColor),
              ),
              Text(
                '${productModel.price} EG',
                style: context.textTheme.labelSmall!.copyWith(
                  color: ColorManager.darkColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          );
        },
        fallback: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${productModel.priceAfterDis} EG',
              style: context.textTheme.labelMedium!
                  .copyWith(color: ColorManager.darkColor),
            ),
          ],
        ),
      ),
    );
  });
}

Widget buildProductsItem({
  required BuildContext context,
  required ProductModel productModel,
  required String locale,
  required Widget favWidget,
  required Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: Device.get().isTablet ? AppSize.ap400 : AppSize.ap300,
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            color: ColorManager.greyLight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: productModel.image,
                  height: 100,
                  width: 200,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      buildCircularProgressIndicatorWithDownload(
                          downloadProgress),
                  errorWidget: (context, url, error) => errorIcon(),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale == "ar"
                            ? productModel.nameAR
                            : productModel.nameEN,
                        style: context.textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(
                        height: 5.0.h,
                      ),
                      buildPrice(productModel),
                      SizedBox(
                        height: 5.0.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: AddToCartButton(productModel, ColorManager.white),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: favWidget,
          ),

          //  displaySaleText(dataModel),
        ],
      ),
    ),
  );
}
