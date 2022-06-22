import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/app/components.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/components/products/functions.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';

import '../../../../../core/resources/strings_manager.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../components/products/components.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late final FavController _favController;
  late final UserDataController _userDataController;

  late final String _language;
  @override
  void initState() {
    _favController = Get.find();
    _language = Get.locale!.languageCode;
    _userDataController = Get.find();
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
                _getContentWidget(),
              )
            : _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return Obx(
      () => BuildCondition(
        condition: _userDataController.userModel.value != null,
        builder: (context) {
          return BuildCondition(
            condition: _favController.productsInFav.isNotEmpty,
            builder: (_) => ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: ColorManager.white,
                child: Padding(
                    padding: EdgeInsets.only(top: 25.0.r),
                    child: Obx(() => ListView.separated(
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildProductsItem(
                            _favController.productsInFav[index],
                          ),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity.w,
                            height: 1.0.h,
                            color: Colors.grey[300],
                          ),
                          itemCount: _favController.productsInFav.length,
                        ))),
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
          );
        },
        fallback: (_) => Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(const $AssetsJsonGen().pleaseLogin, width: 300.w),
            Text(
              AppStrings.pleaseLogin,
              style: context.textTheme.labelLarge,
            ),
          ],
        )),
      ),
    );
  }

  Widget buildProductsItem(ProductModel productData) {
    return InkWell(
      onTap: () {
        goToProductDetails(productData);
      },
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                SizedBox(
                  child: Card(
                    color: ColorManager.greyLight,
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: CachedNetworkImage(
                        imageUrl: productData.image,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child:
                                    buildCircularProgressIndicatorWithDownload(
                                        downloadProgress)),
                        errorWidget: (context, url, error) => errorIcon(),
                      ),
                    ),
                  ),
                ),
                //if (productData.sale == 1)
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Container(
                //     width: 30.w,
                //     height: 25.h,
                //     decoration: BoxDecoration(
                //       color: Colors.deepOrange,
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //     child: Center(
                //       child: Text(
                //         'SALE',
                //         style: TBIBFontStyle.h2.copyWith(
                //           fontSize: 10.0.sp,
                //           color: Colors.white70,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            width: 10.0.w,
          ),
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
                          radius: 25.0.r,
                          backgroundColor: Colors.grey[400],
                          child: IconButton(
                            onPressed: () {
                              _favController.addToFavoriteEvent(productData);
                            },
                            icon: Icon(
                              Icons.favorite_sharp,
                              color: Colors.red,
                              size: 30.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0.h,
                  ),
                  buildPrice(productData),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  AddToCartButton(productData, ColorManager.greyLight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
