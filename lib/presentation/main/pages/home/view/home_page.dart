import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:ms_store/gen/assets.gen.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import '../../../../../app/components.dart';
import '../../../../../core/resources/styles_manger.dart';
import '../../../../../domain/models/home_models/category_home_model.dart';
import '../../../../../domain/models/home_models/data_home_model.dart';
import '../../../../../domain/models/store/product_model.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

import '../../../../../domain/models/home_models/slider_model.dart';
import '../../../../components/products/components.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manger.dart';
import '../../../../../core/resources/icons_manger.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../view_model/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String locale = Get.locale!.languageCode;

  late final HomeController _homeController;

  @override
  void initState() {
    _homeController = Get.find();
    _homeController.getHomeData();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _homeController.homeModel.value = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _homeController.homeModel.value = null;
    }
    if (state == AppLifecycleState.resumed) {
      _homeController.getHomeData();
    }
  }

  Widget buildCategory(int index, CategoryHomeModel mainCatModel) => Container(
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
                onPressed: () {
                  _homeController.goCategory(index);
                },
                icon: Icon(
                  locale == "ar"
                      ? IconsManger.arrowLeft
                      : IconsManger.arrowRight,
                  color: ColorManager.white,
                  size: AppSize.ap30,
                )),
          ],
        ),
      );

  Widget buildProductsItem(ProductModel productModel) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: Device.get().isTablet ? AppSize.ap400 : AppSize.ap300,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              color: ColorManager.greyLight,
              child: Column(
                children: [
                  SizedBox(
                    width:
                        Device.get().isTablet ? AppSize.ap400 : AppSize.ap300,
                    height: 150,
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: productModel.image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: buildCircularProgressIndicatorWithDownload(
                            downloadProgress),
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
                          style: context.textTheme.labelSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
              child: AddToCartButton(productModel),
            ),
            addToFavoriteButton(
                () => _homeController.addToFavoriteEvent(productModel.id),
                productModel.id),
            //  displaySaleText(dataModel),
          ],
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return BuildCondition(
      condition:
          _homeController.homeModel.value?.data.dataHome.isNotEmpty ?? false,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getSliderCarousel(),
          _getSection(AppStrings.latestProducts),
          _getProducts(_homeController.homeModel.value?.data.dataHome ??
              const Iterable.empty().cast<DataHomeModel>().toList()),
        ],
      ),
      fallback: (_) => Column(
        children: [
          Lottie.asset(const $AssetsJsonGen().empty),
          Text(
            AppStrings.noProducts,
            style: context.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _getSliderCarousel() {
    return Obx(
        () => _getSliderWidget(_homeController.homeModel.value?.data.slider));
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
        padding: const EdgeInsets.only(top: 20.0),
        child: CarouselSlider(
            items: sliders
                .map((slider) => SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: ColorManager.primaryColor,
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
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: buildCircularProgressIndicatorWithDownload(
                                  downloadProgress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl: locale == "en"
                                ? slider.imageEN
                                : slider.imageAR,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250.h,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            )),
      );
    }
  }

  Widget _getProducts(List<DataHomeModel> dataHome) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: _homeController.homeModel.value?.data.dataHome.length ?? 0,
        itemBuilder: (context, indexCat) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCategory(indexCat, dataHome[indexCat].categoryModel),
            SizedBox(
              height: Device.get().isTablet ? AppSize.ap350 : AppSize.ap300,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, indexPro) {
                  return buildProductsItem(
                      dataHome[indexCat].productModel[indexPro]);
                },
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: dataHome[indexCat].productModel.length > 4
                    ? 4
                    : dataHome[indexCat].productModel.length,
              ),
            ),
            const Divider(
              thickness: 0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: InputField(
          themeDataText: context.textTheme,
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
                    _getContentWidget(), retryActionFunction: () {
                    _homeController.getHomeData();
                  })
                : _getContentWidget()),
          ),
        ),
      ),
    );
  }
}
