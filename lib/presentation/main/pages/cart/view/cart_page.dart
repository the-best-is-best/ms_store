import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/font_manger.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/gen/assets.gen.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';

import '../../../../../core/resources/strings_manager.dart';
import '../../../../components/products/components.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartController _cartController;
  late final String _language;

  @override
  void initState() {
    _cartController = Get.find();
    _language = Get.locale!.languageCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.cartTitle,
          style: context.textTheme.displayLarge,
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            BuildCondition(
              condition: _cartController.productsInCart.isNotEmpty,
              builder: (_) => ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  color: Colors.white,
                  axisDirection: AxisDirection.down,
                  child: ListView.builder(
                    itemCount: _cartController.productsInCart.length,
                    itemBuilder: (context, index) =>
                        buildCartItem(_cartController.productsInCart[index]),
                  ),
                ),
              ),
              fallback: (_) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(const $AssetsJsonGen().empty, width: 300.w),
                    Text(
                      AppStrings.noProducts,
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.greyLight,
                        offset: Offset(2.0, 2.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  width: context.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: AppSpacing.ap12),
                            child: Row(
                              children: [
                                Text(
                                  "Total : ",
                                  style: context.textTheme.labelMedium,
                                ),
                                SizedBox(
                                  width: AppSpacing.ap8.w,
                                ),
                                Text(
                                  '${_cartController.totalPrice} EG',
                                  style: context.textTheme.labelLarge!
                                      .copyWith(color: ColorManager.darkColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                AppStrings.checkout,
                              )),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(ProductModel cartData) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() => IconButton(
                    icon: Icon(
                      IconsManger.delete,
                      color: Colors.red,
                      size: FontSize.s30,
                    ),
                    onPressed: _cartController.productId.value != null
                        ? null
                        : () async {
                            _cartController.deleteFromCart(cartData);
                          },
                  )),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.greyLight,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CachedNetworkImage(
                    imageUrl: cartData.image,
                    fit: BoxFit.contain,
                    height: 130,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            buildCircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: FontSize.s30,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.0.r,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Text(
                              _language == "ar"
                                  ? cartData.nameAR
                                  : cartData.nameEN,
                              style: context.textTheme.labelMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.ap18,
                          ),
                          Text(
                            cartData.priceAfterDis == 0
                                ? cartData.price.toString()
                                : cartData.priceAfterDis.toString(),
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    Positioned.directional(
                      bottom: 0,
                      start: 15,
                      textDirection: _language == "ar"
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.greyLight,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: AddToCartButton(
                              cartData, ColorManager.greyLight)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
