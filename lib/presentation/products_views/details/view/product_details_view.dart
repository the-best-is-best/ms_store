import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/components/products/components.dart';
import 'package:ms_store/presentation/products_views/details/controller/product_details_controller.dart';

import '../../../../app/components.dart';
import '../../../../core/resources/font_manger.dart';
import '../../../../core/resources/styles_manger.dart';
import '../../../../domain/models/store/reviews_model.dart';
import '../../../../gen/assets.gen.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product = Get.arguments['product'];
  ProductDetailsView({Key? key}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final String _language;
  late final ProductDetailsController _productDetailsController;
  late final UserDataController _userDataController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _language = Get.locale!.languageCode;
    _productDetailsController = Get.find();
    _productDetailsController.currentProduct.add(widget.product);
    _productDetailsController.getData(widget.product.categoryId);
    _userDataController = Get.find();
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
                expandedHeight: .4.sh,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned(
                        child: Center(
                          child: SizedBox(
                            height: .4.sh,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(AppSize.ap8),
                              ),
                              child: Obx(() => CachedNetworkImage(
                                    imageUrl: _productDetailsController
                                        .currentProduct[
                                            _productDetailsController
                                                .currentIndex]
                                        .image,
                                    fit: BoxFit.contain,
                                    width: .55.sw,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        buildCircularProgressIndicatorWithDownload(
                                            downloadProgress),
                                    errorWidget: (context, url, error) =>
                                        errorIcon(),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        right: 15,
                        top: .15.sh,
                        child: Row(children: [
                          Icon(
                            IconsManger.stars,
                            color: ColorManager.yellow,
                            size: FontSize.s40,
                          ),
                          const SizedBox(
                            width: AppSpacing.ap8,
                          ),
                          Text(
                            _productDetailsController
                                .reviewProduct.value!.productRating
                                .toString(),
                            style: context.textTheme.labelMedium,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: AppSize.ap14, end: AppSize.ap14),
                    child: AddToFavoriteButton(
                        product: _productDetailsController.currentProduct[
                            _productDetailsController.currentIndex]),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.ap12),
                  child: Column(children: [
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
                          alignment: _language == "ar"
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Text(
                            AppStrings.description,
                            style: context.textTheme.labelLarge,
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
                          maxLines: 6,
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
                    Obx(
                      () => Column(
                        children: [
                          Align(
                            alignment: _language == "ar"
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Text(
                              AppStrings.reviews,
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          BuildCondition(
                            condition:
                                _userDataController.userModel.value != null,
                            builder: (_) => TextButton(
                              onPressed: () async {
                                await ratingDialog();
                              },
                              child: Obx(() => BuildCondition(
                                    condition: _productDetailsController
                                                .userReview.value ==
                                            null &&
                                        (_productDetailsController
                                                    .userReview.value?.rating ==
                                                null ||
                                            _productDetailsController
                                                    .userReview.value?.rating ==
                                                0) &&
                                        _productDetailsController
                                                .userReview.value?.comment ==
                                            null,
                                    builder: (context) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          AppStrings.writeYourReview,
                                          style: context.textTheme.labelMedium!
                                              .copyWith(
                                                  color:
                                                      ColorManager.darkColor),
                                        ),
                                      );
                                    },
                                    fallback: (_) {
                                      return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: AppSpacing.ap12),
                                                child: Text(
                                                  AppStrings.yourReview,
                                                  style: context
                                                      .textTheme.labelMedium,
                                                ),
                                              ),
                                              Text(
                                                _productDetailsController
                                                        .userReview
                                                        .value
                                                        ?.comment ??
                                                    "",
                                                style: context
                                                    .textTheme.labelSmall,
                                              ),
                                            ]),
                                            RatingBarIndicator(
                                              rating: _productDetailsController
                                                      .userReview
                                                      .value
                                                      ?.rating ??
                                                  0,
                                              itemSize: FontSize.s30,
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                IconsManger.stars,
                                                color: ColorManager.yellow,
                                              ),
                                              itemCount: 5,
                                              direction: Axis.horizontal,
                                            ),
                                          ]);
                                    },
                                  )),
                            ),
                            fallback: (_) => Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppStrings.pleaseLogin} ${AppStrings.toReview}",
                                  style: context.textTheme.labelMedium,
                                ),
                                Lottie.asset(const $AssetsJsonGen().pleaseLogin,
                                    height: 150.h),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                    BuildCondition(
                      condition: _productDetailsController
                          .reviewProduct.value?.dataReview.isNotEmpty,
                      builder: (_) => buildReviews(_productDetailsController
                          .reviewProduct.value!.dataReview),
                      fallback: (_) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppStrings.noReviews,
                            style: context.textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSpacing.ap18,
                    ),
                    BuildCondition(
                      condition:
                          _productDetailsController.productSupplier.isNotEmpty,
                      builder: (_) => Column(
                        children: [
                          Text(
                            AppStrings.latestProducts,
                            style: getBoldStyle(
                                fontSize: FontSize.s24,
                                color: ColorManager.darkColor),
                          ),
                          const Divider(
                            thickness: 0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSize.ap8.h,
                    ),
                    SizedBox(
                      height:
                          Device.get().isTablet ? AppSize.ap350 : AppSize.ap300,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return buildProductsItem(
                            productModel: _productDetailsController
                                .productSupplier[index],
                            context: context,
                            locale: _language,
                            onTap: () {
                              _productDetailsController.setCurrentPage(
                                  nextProduct: _productDetailsController
                                      .productSupplier[index]);
                            },
                            favWidget: AddToFavoriteButton(
                                product: _productDetailsController
                                    .productSupplier[index]),
                          );
                        },
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
            child: Container(
              color: ColorManager.white,
              width: context.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.ap4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppStrings.price,
                          style: context.textTheme.labelSmall,
                        ),
                        SizedBox(
                          height: AppSpacing.ap4.h,
                        ),
                        buildPrice(
                            _productDetailsController.currentProduct[
                                _productDetailsController.currentIndex],
                            detailsPage: true),
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
            ),
          )
        ],
      ),
    );
  }

  Future ratingDialog() async {
    await showMyDialog(
        context: context,
        title: _language == "ar"
            ? _productDetailsController
                .currentProduct[_productDetailsController.currentIndex].nameAR
            : _productDetailsController
                .currentProduct[_productDetailsController.currentIndex].nameEN,
        textStyle: context.textTheme.labelMedium!,
        paddingTitle: const EdgeInsets.symmetric(
            horizontal: AppSpacing.ap12, vertical: AppSpacing.ap8),
        content: [
          Builder(builder: (context) {
            _productDetailsController.addRating(
                _productDetailsController.userReview.value?.rating ?? 0);
            return RatingBar.builder(
              initialRating:
                  _productDetailsController.userReview.value?.rating ?? 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: FontSize.s40,
              itemBuilder: (context, _) => const Icon(
                IconsManger.stars,
                color: ColorManager.yellow,
              ),
              onRatingUpdate: (rating) {
                _productDetailsController.addRating(rating);
              },
            );
          }),
          const SizedBox(height: AppSize.ap14),
          Form(key: _formKey, child: const CommentDialog()),
        ],
        actions: [
          ElevatedButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();

                await waitStateChanged(duration: 540);
                Get.back();

                _productDetailsController.updateReview();
              },
              child: Text(AppStrings.send))
        ]);
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

  Widget buildReviews(List<ReviewsProductModel> reviews) {
    return ListView.builder(
      itemCount: reviews.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.width * 1 / 3,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          reviews[index].userName,
                          style: context.textTheme.labelLarge!
                              .copyWith(fontSize: null),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSpacing.ap12,
                    ),
                    Text(
                      reviews[index].comment,
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RatingBarIndicator(
                  rating: reviews[index].rating,
                  itemSize: FontSize.s32,
                  itemBuilder: (context, _) => const Icon(
                    IconsManger.stars,
                    color: ColorManager.yellow,
                  ),
                  itemCount: 5,
                  direction: Axis.horizontal,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.ap16,
          ),
        ],
      ),
    );
  }
}

class CommentDialog extends StatefulWidget {
  const CommentDialog({Key? key}) : super(key: key);

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  late final TextEditingController commentTextEditingController;
  late final ProductDetailsController productDetailsController;
  @override
  void initState() {
    commentTextEditingController = TextEditingController();

    productDetailsController = Get.find();
    commentTextEditingController.text =
        productDetailsController.userReview.value?.comment ?? "";
    productDetailsController.addComment(commentTextEditingController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: commentTextEditingController,
      label: 'Tell us your experience ',
      keyBoardType: TextInputType.text,
      prefixIcon: IconsManger.comments,
      themeDataText: context.textTheme,
      onChanged: (String? value) {
        productDetailsController.addComment(value ?? "");
      },
    );
  }
}
