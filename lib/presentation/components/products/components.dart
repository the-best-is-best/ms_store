import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/icons_manger.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import '../../../app/components/common/build_circular_progress_indicator.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/util/get_device_type.dart';
import '../../main/pages/fav/view_model/fav_controller.dart';

class AddToCartButton extends StatefulWidget {
  final ProductModel product;
  final Color circleColor;
  final CartController cartController;
  const AddToCartButton(this.product, this.circleColor,
      {Key? key, required this.cartController})
      : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BuildCondition(
        condition: widget.cartController.cartModel[widget.product.id] == null ||
            widget.cartController.cartModel[widget.product.id] == 0,
        builder: (_) => ElevatedButton(
          onPressed: () async {
            widget.cartController.addToCart(widget.product, false);
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
                    size: FontSize.s30,
                  ),
                  onPressed: widget.cartController.productId.value != null
                      ? null
                      : () {
                          widget.cartController
                              .addToCart(widget.product, false);
                        },
                )),
          ),
          CircleAvatar(
            backgroundColor: widget.circleColor,
            child: Obx(
              () => BuildCondition(
                condition: widget.cartController.productId.value == null ||
                    widget.cartController.productId.value != widget.product.id,
                builder: (_) => Text(
                    widget.cartController.cartModel[widget.product.id]!
                        .toString(),
                    style: context.textTheme.labelMedium!
                        .copyWith(color: ColorManager.darkColor)),
                fallback: (_) => const BuildCircularProgressIndicator(),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: widget.circleColor,
            child: Obx(() => IconButton(
                  icon: Icon(
                    IconsManger.plus,
                    size: FontSize.s30,
                  ),
                  onPressed: widget.cartController.productId.value != null
                      ? null
                      : () {
                          widget.cartController.addToCart(widget.product, true);
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
  final FavController favController;
  const AddToFavoriteButton(
      {Key? key, required this.product, required this.favController})
      : super(key: key);

  @override
  State<AddToFavoriteButton> createState() => _AddToFavoriteButtonState();
}

class _AddToFavoriteButtonState extends State<AddToFavoriteButton> {
  late bool inFav;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[400],
        child: Obx(() => BuildCondition(
              condition:
                  widget.favController.productId.value != widget.product.id,
              builder: (context) {
                return IconButton(
                  onPressed: widget.favController.productId.value != null
                      ? null
                      : () {
                          widget.favController
                              .addToFavoriteEvent(widget.product);
                        },
                  icon: Builder(builder: (context) {
                    inFav =
                        widget.favController.favoriteModel[widget.product.id] ==
                            true;

                    return Icon(
                      inFav
                          ? IconsManger.addedToFavorite
                          : IconsManger.addToFavorite,
                      color: inFav ? ColorManager.error : Colors.white,
                      size: 25.0,
                    );
                  }),
                );
              },
              fallback: (_) =>
                  const Center(child: BuildCircularProgressIndicator()),
            )));
  }
}

class BuildPrice extends StatelessWidget {
  final ProductModel productModel;
  final bool detailsPage;
  const BuildPrice(
      {Key? key, required this.productModel, this.detailsPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildCondition(
      condition: productModel.priceAfterDis == 0.0,
      builder: (context) {
        return Row(
          children: [
            Text(
              '${productModel.price} EG',
              style: context.textTheme.labelMedium!.copyWith(
                  color: ColorManager.darkColor, fontSize: FontSize.s16),
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
                style: context.textTheme.labelMedium!.copyWith(
                    color: ColorManager.darkColor, fontSize: FontSize.s16),
              ),
              Text(
                '${productModel.price} EG',
                style: context.textTheme.labelSmall!.copyWith(
                  color: ColorManager.darkColor,
                  fontSize: 12.sp,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          );
        },
        fallback: (_) => Row(
          children: [
            Text(
              '${productModel.priceAfterDis} EG',
              style: context.textTheme.labelMedium!.copyWith(
                  color: ColorManager.darkColor, fontSize: FontSize.s16),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildProductItem extends StatelessWidget {
  final ProductModel productModel;
  final String locale;
  final CartController cartController;
  final Widget favWidget;

  final Function() onTap;
  const BuildProductItem(
      {Key? key,
      required this.productModel,
      required this.favWidget,
      required this.onTap,
      required this.locale,
      required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: AppSize.ap300,
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
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            BuildCircularProgressIndicatorWithDownload(
                                downloadProgress),
                    errorWidget: (context, url, error) => const ErrorIcon(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSize.ap12),
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
                        const SizedBox(height: 5.0),
                        BuildPrice(productModel: productModel),
                        const SizedBox(height: 5.0),
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
              child: AddToCartButton(
                productModel,
                ColorManager.white,
                cartController: cartController,
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: favWidget,
            ),
            DisplaySaleText(productModel),
          ],
        ),
      ),
    );
  }
}

class DisplaySaleText extends StatelessWidget {
  final ProductModel productModel;
  const DisplaySaleText(
    this.productModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildCondition(
        condition: productModel.priceAfterDis != 0,
        builder: (context) {
          return Positioned(
            top: 5,
            left: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: DeviceType.Tablet == getDeviceType() ? 50.w : 65.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    AppStrings.sale,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium!
                        .copyWith(color: ColorManager.white),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
