import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/components.dart';
import '../../../../../domain/models/home_models/product_model_home.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

import '../../../../../domain/models/home_models/slider_model.dart';
import '../../../../../domain/models/store/category_model.dart';
import '../../../../components/products/components.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/font_manger.dart';
import '../../../../resources/icons_manger.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/styles_manger.dart';
import '../../../../resources/values_manager.dart';
import '../view_model/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String locale = Get.locale!.languageCode;
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: InputField(
          themeData: themeData,
          keyBoardType: TextInputType.text,
          label: 'Search',
          prefixIcon: IconsManger.search,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            //top: AppSpacing.ap8.h,
            left: AppSpacing.ap8.w,
            right: AppSpacing.ap8.w),
        child: Center(
          child: SingleChildScrollView(
            child: Obx(() => _homeController.flowState.value != null
                ? _homeController.flowState.value!.getScreenWidget(
                    _getContentWidget(themeData), retryActionFunction: () {
                    _homeController.getHomeData();
                  })
                : _getContentWidget(themeData)),
          ),
        ),
      ),
    );
  }

  Widget _getContentWidget(ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getSliderCarousel(),
        _getSection(AppStrings.latestProducts),
        _getProducts(themeData),
      ],
    );
  }

  Widget _getSliderCarousel() {
    return Obx(() => _getSliderWidget(_homeController.sliderModel));
  }

  Widget _getSection(String text) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.ap12.w, vertical: AppSpacing.ap20.h),
          child: Text(
            text,
            style: getBoldStyle(
                fontSize: FontSize.s24, color: ColorManager.darkColor),
          ),
        ),
        const Divider(
          thickness: 0,
        )
      ],
    );
  }

  Widget _getSliderWidget(List<SliderModel>? sliders) {
    if (sliders == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: CarouselSlider(
            items: sliders
                .map((slider) => SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: AppSpacing.ap1_5,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.ap12.r),
                            side: BorderSide(
                                color: ColorManager.darkColor,
                                width: AppSpacing.ap4.w)),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.ap12.r),
                          child: Image.network(
                            locale == "en" ? slider.imageEN : slider.imageAR,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: AppSize.s300.h,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            )),
      );
    }
  }

  Widget _getProducts(ThemeData themeData) {
    return Obx(() => BuildCondition(
          condition: _homeController.dataHome.isNotEmpty,
          builder: (context) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _homeController.dataHome.length,
            itemBuilder: (context, indexCat) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCategory(_homeController.dataHome[indexCat].categoryModel),
                SizedBox(
                  height: (AppSize.s300 + 5).h,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, indexPro) {
                      return buildProductsItem(_homeController
                          .dataHome[indexCat].productModel[indexPro]);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: 0.0.w,
                    ),
                    itemCount:
                        _homeController.dataHome[indexCat].productModel.length >
                                4
                            ? 4
                            : _homeController
                                .dataHome[indexCat].productModel.length,
                  ),
                ),
                const Divider(
                  thickness: 0,
                ),
              ],
            ),
          ),
          fallback: (_) => Center(
            child: Text(
              AppStrings.noProducts,
              style: themeData.textTheme.titleMedium,
            ),
          ),
        ));
  }

  Widget buildCategory(CategoryModel mainCatModel) => Container(
        color: ColorManager.darkColor,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.ap12.w, vertical: AppSpacing.ap20.h),
              child: Text(
                locale == "en" ? mainCatModel.nameEN : mainCatModel.nameAR,
                style: getBoldStyle(
                    fontSize: FontSize.s24, color: ColorManager.white),
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: Icon(
                    locale == "ar"
                        ? IconsManger.arrowLeft
                        : IconsManger.arrowRight,
                    color: ColorManager.white)),
          ],
        ),
      );
  Widget buildProductsItem(ProductModeHome productModel) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: AppSize.s300.w,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              color: ColorManager.greyLight,
              child: Column(
                children: [
                  SizedBox(
                    width: AppSize.s300,
                    height: 150.h,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: productModel.image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            color: ColorManager.primaryColor,
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        //     buildPrice(dataModel),
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
              child: addToCartButton(productModel.id),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: CircleAvatar(
                radius: 27.sp,
                backgroundColor: Colors.grey[400],
                child: IconButton(
                  onPressed: () {
                    /* if (LoginCubit.get(context).loginModel != null &&
                        LoginCubit.get(context).loginModel!.data != null) {
                      ShopCubit.get(context).updateFavorite(context,
                          userId: LoginCubit.get(context).loginModel!.data!.id!,
                          productId: dataModel.id!);
                    } else {
                      navigateTo(context, LoginScreen());
                    }*/
                  },
                  icon: Icon(
                    //  inFav == 1
                    //   ? Icons.favorite_sharp
                    Icons.favorite_border_outlined,
                    // color: inFav == 1 ? Colors.red : Colors.white,
                    color: Colors.white,
                    size: 33.0.sp,
                  ),
                ),
              ),
            ),
            //  displaySaleText(dataModel),
          ],
        ),
      ),
    );
  }
}
