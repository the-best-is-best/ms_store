import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:expandable/expandable.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/components/products/components.dart';
import 'package:ms_store/presentation/products_views/details/controller/product_details_controller.dart';

import '../../../../app/components.dart';
import '../../../../core/resources/font_manger.dart';
import '../../../../core/resources/styles_manger.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product = Get.arguments['product'];
  ProductDetailsView({Key? key}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final String _language;
  late final ProductDetailsController _productDetailsController;

  @override
  void initState() {
    _language = Get.locale!.languageCode;
    _productDetailsController = Get.find();
    _productDetailsController.currentProduct.add(widget.product);
    _productDetailsController.getData(widget.product.categoryId);
    super.initState();
  }

  Widget _getContentWidget() {
    return Obx(
      () => Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: .5.sh,
                title: Text(
                    _language == "ar"
                        ? _productDetailsController
                            .currentProduct[
                                _productDetailsController.currentIndex]
                            .nameAR
                        : _productDetailsController
                            .currentProduct[
                                _productDetailsController.currentIndex]
                            .nameEN,
                    style: context.textTheme.titleMedium),
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppSize.ap8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: _productDetailsController
                            .currentProduct[
                                _productDetailsController.currentIndex]
                            .image,
                        height: .3.sh,
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppSize.ap12, right: AppSize.ap14),
                    child: addToFavoriteButton(() {
                      _productDetailsController.addToFavorite(
                          _productDetailsController.currentProduct[
                              _productDetailsController.currentIndex]);
                    },
                        _productDetailsController
                            .currentProduct[
                                _productDetailsController.currentIndex]
                            .id),
                  ),
                ],
                leading: IconButton(
                  icon: Icon(GetPlatform.isIOS
                      ? CupertinoIcons.back
                      : Icons.arrow_back),
                  onPressed: () {
                    _productDetailsController.setCurrentPage();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    SizedBox(
                      height: AppSize.ap18.h,
                    ),
                    Text(
                      _language == "ar"
                          ? _productDetailsController
                              .currentProduct[
                                  _productDetailsController.currentIndex]
                              .nameAR
                          : _productDetailsController
                              .currentProduct[
                                  _productDetailsController.currentIndex]
                              .nameEN,
                      style: context.textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: AppSize.ap18.h,
                    ),
                    ExpandableNotifier(
                      child: ExpandablePanel(
                        header: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppStrings.description,
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                        collapsed: Text(
                          _language == "ar"
                              ? _productDetailsController
                                  .currentProduct[
                                      _productDetailsController.currentIndex]
                                  .descriptionAR
                              : _productDetailsController
                                  .currentProduct[
                                      _productDetailsController.currentIndex]
                                  .descriptionEN,
                          overflow: TextOverflow.ellipsis,
                          maxLines: Device.get().isTablet ? 4 : 2,
                          softWrap: true,
                          style: context.textTheme.labelSmall,
                        ),
                        expanded: Text(
                          _language == "ar"
                              ? _productDetailsController
                                  .currentProduct[
                                      _productDetailsController.currentIndex]
                                  .descriptionAR
                              : _productDetailsController
                                  .currentProduct[
                                      _productDetailsController.currentIndex]
                                  .descriptionEN,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.ap18.h,
                    ),
                    BuildCondition(
                      condition:
                          _productDetailsController.productSupplier.isNotEmpty,
                      builder: (_) => Column(children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.ap12.w,
                                  vertical: AppSpacing.ap20.h),
                              child: Text(
                                AppStrings.latestProducts,
                                style: getBoldStyle(
                                    fontSize: FontSize.s24,
                                    color: ColorManager.darkColor),
                              ),
                            ),
                            const Divider(
                              thickness: 0,
                            ),
                          ],
                        )
                      ]),
                    ),
                    SizedBox(
                      height: AppSize.ap8.h,
                    ),
                    SizedBox(
                      height:
                          Device.get().isTablet ? AppSize.ap350 : AppSize.ap300,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildProductsItemHorizontal(
                            productModel: _productDetailsController
                                .productSupplier[index],
                            context: context,
                            locale: _language,
                            fromProductDetails: true,
                            favWidget: addToFavoriteButton(() {
                              _productDetailsController.addToFavorite(
                                  _productDetailsController
                                      .productSupplier[index]);
                            },
                                _productDetailsController
                                    .productSupplier[index].id),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount:
                            _productDetailsController.productSupplier.length > 4
                                ? 4
                                : _productDetailsController
                                    .productSupplier.length,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.ap80.h,
                    )
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: context.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'price',
                        style: context.textTheme.labelSmall,
                      ),
                      SizedBox(
                        height: AppSpacing.ap4.h,
                      ),
                      buildPrice(_productDetailsController.currentProduct[
                          _productDetailsController.currentIndex]),
                    ],
                  ),
                  SizedBox(
                      width: .5.sw,
                      child: AddToCartButton(
                          _productDetailsController.currentProduct[
                              _productDetailsController.currentIndex],
                          ColorManager.greyLight)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _productDetailsController.setCurrentPage();
        return false;
      },
      child: Scaffold(
        body: Obx(() => _productDetailsController.flowState.value != null
            ? _productDetailsController.flowState.value!
                .getScreenWidget(_getContentWidget(), retryActionFunction: () {
                _productDetailsController.getData(_productDetailsController
                    .currentProduct[_productDetailsController.currentIndex]
                    .categoryId);
              })
            : _getContentWidget()),
      ),
    );
  }
}
