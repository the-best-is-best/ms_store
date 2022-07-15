import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/components/products/functions.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';

import '../../../../../app/components/common/build_circular_progress_indicator.dart';
import '../../../../../app/resources/strings_manager.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../components/products/components.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late final FavController _favController;
  late final UserDataController _userDataController;
  late final CartController _cartController;

  @override
  void initState() {
    _favController = Get.find();
    _userDataController = Get.find();
    _cartController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.favTitle,
          style: context.textTheme.displayLarge,
        ),
      ),
      body: Obx(
        () => _favController.flowState.value != null
            ? _favController.flowState.value!.getScreenWidget(
                _GetContentWidget(
                  cartController: _cartController,
                  userDataController: _userDataController,
                  favController: _favController,
                ),
              )
            : _GetContentWidget(
                cartController: _cartController,
                userDataController: _userDataController,
                favController: _favController,
              ),
      ),
    );
  }
}

class _GetContentWidget extends StatelessWidget {
  final UserDataController userDataController;
  final FavController favController;
  final CartController cartController;

  const _GetContentWidget(
      {Key? key,
      required this.favController,
      required this.cartController,
      required this.userDataController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BuildCondition(
        condition: userDataController.userModel.value != null,
        builder: (context) {
          return BuildCondition(
            condition: favController.productsInFav.isNotEmpty,
            builder: (_) => ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: ColorManager.white,
                child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Obx(() => ListView.separated(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => BuildProductsItem(
                            favController: favController,
                            productData: favController.productsInFav[index],
                            cartController: cartController,
                          ),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                          itemCount: favController.productsInFav.length,
                        ))),
              ),
            ),
            fallback: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(const $AssetsJsonGen().empty, width: 300),
                  Text(
                    AppStrings.noProducts,
                    style: context.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          );
        },
        fallback: (_) => Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(const $AssetsJsonGen().pleaseLogin, width: 300),
            Text(
              AppStrings.pleaseLogin,
              style: context.textTheme.labelLarge,
            ),
          ],
        )),
      ),
    );
  }
}

class BuildProductsItem extends StatelessWidget {
  final FavController favController;
  final ProductModel productData;
  final CartController cartController;

  const BuildProductsItem(
      {Key? key,
      required this.productData,
      required this.favController,
      required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _language = Get.locale!.languageCode;

    return InkWell(
      onTap: () {
        goToProductDetails(productData);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Card(
                    color: ColorManager.greyLight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CachedNetworkImage(
                        imageUrl: productData.image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                BuildCircularProgressIndicatorWithDownload(
                                    downloadProgress),
                        errorWidget: (context, url, error) => const ErrorIcon(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSize.ap12),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            _language == "ar"
                                ? productData.nameAR
                                : productData.nameEN,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.grey[400],
                            child: BuildCondition(
                              condition: favController.productId.value !=
                                  productData.id,
                              builder: (context) {
                                return IconButton(
                                  onPressed: favController.productId.value !=
                                          null
                                      ? null
                                      : () {
                                          favController
                                              .addToFavoriteEvent(productData);
                                        },
                                  icon: Icon(
                                    Icons.favorite_sharp,
                                    color: Colors.red,
                                    size: FontSize.s30,
                                  ),
                                );
                              },
                              fallback: (_) =>
                                  const BuildCircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.ap14),
                    BuildPrice(productModel: productData),
                    const SizedBox(height: 20.0),
                    AddToCartButton(
                      productData,
                      ColorManager.greyLight,
                      cartController: cartController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
