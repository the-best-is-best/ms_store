import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/util/get_device_type.dart';
import 'package:ms_store/presentation/components/products/functions.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';
import '../../../../../app/components.dart';
import '../../../../../app/components/common/build_circular_progress_indicator.dart';
import '../../../../../app/components/common/input_field.dart';
import '../../../../../app/di.dart';
import '../../../../../app/resources/routes_manger.dart';
import '../../../../../app/resources/styles_manger.dart';
import '../../../../../domain/models/home_models/category_home_model.dart';
import '../../../../../domain/models/home_models/data_home_model.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../domain/models/home_models/slider_model.dart';
import '../../../../components/products/components.dart';
import '../../../../../app/resources/color_manager.dart';
import '../../../../../app/resources/font_manger.dart';
import '../../../../../app/resources/icons_manger.dart';
import '../../../../../app/resources/strings_manager.dart';
import '../../../../../app/resources/values_manager.dart';
import '../../cart/view_model/cart_controller.dart';
import '../view_model/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String locale = Get.locale!.languageCode;
  late final CartController _cartController;
  late final FavController _favController;

  late final HomeController _homeController;
  late final TextEditingController searchTextEditingController;

  @override
  void initState() {
    _homeController = Get.find();
    _cartController = Get.find();
    _favController = Get.find();
    //  _homeController.getHomeData();
    searchTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InputField(
          controller: searchTextEditingController,
          keyBoardType: TextInputType.text,
          label: AppStrings.search,
          prefixIcon: IconsManger.search,
          onEditingComplete: () {
            initProductBySearch();
            Get.toNamed(Routes.searchRoute,
                arguments: {'searchText': searchTextEditingController.text});
          },
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: AppSpacing.ap8, right: AppSpacing.ap8),
        child: Center(
          child: SingleChildScrollView(
            child: Obx(() => _homeController.flowState.value != null
                ? _homeController.flowState.value!.getScreenWidget(
                    _GetContentWidget(
                      favController: _favController,
                      cartController: _cartController,
                      homeController: _homeController,
                    ), retryActionFunction: () {
                    _homeController.getHomeData();
                  })
                : BuildCondition(
                    condition: _homeController.homeModel.value != null,
                    builder: (context) {
                      return _GetContentWidget(
                        favController: _favController,
                        cartController: _cartController,
                        homeController: _homeController,
                      );
                    })),
          ),
        ),
      ),
    );
  }
}

class _BuildCategory extends StatelessWidget {
  final int index;
  final CategoryHomeModel mainCatModel;
  final HomeController homeController;
  const _BuildCategory(
      {Key? key,
      required this.index,
      required this.mainCatModel,
      required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String locale = Get.locale!.languageCode;
    return Container(
      color: ColorManager.darkColor,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.ap12, vertical: AppSpacing.ap20),
            child: Text(
              locale == "en" ? mainCatModel.nameEN : mainCatModel.nameAR,
              style: getBoldStyle(
                  fontSize: FontSize.s24, color: ColorManager.white),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                homeController.goCategory(index);
              },
              icon: Icon(
                locale == "ar" ? IconsManger.arrowLeft : IconsManger.arrowRight,
                color: ColorManager.white,
                size: AppSize.ap30,
              )),
        ],
      ),
    );
  }
}

class _GetContentWidget extends StatelessWidget {
  final HomeController homeController;
  final CartController cartController;
  final FavController favController;

  const _GetContentWidget(
      {Key? key,
      required this.homeController,
      required this.cartController,
      required this.favController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GetSliderCarousel(
          homeController: homeController,
        ),
        _GetSection(text: AppStrings.latestProducts),
        _GetProducts(
          homeController: homeController,
          dataHome: homeController.homeModel.value?.data.dataHome ??
              const Iterable.empty().cast<DataHomeModel>().toList(),
          cartController: cartController,
          favController: favController,
        ),
      ],
    );
  }
}

class _GetSliderCarousel extends StatelessWidget {
  final HomeController homeController;
  const _GetSliderCarousel({Key? key, required this.homeController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _GetSliderWidget(
          sliders: homeController.homeModel.value?.data.slider,
          homeController: homeController,
        ));
  }
}

class _GetSection extends StatelessWidget {
  final String text;
  const _GetSection({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.ap12, vertical: AppSpacing.ap20),
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
}

class _GetSliderWidget extends StatelessWidget {
  final HomeController homeController;
  final List<SliderModel>? sliders;
  const _GetSliderWidget({Key? key, required this.homeController, this.sliders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String locale = Get.locale!.languageCode;
    if (sliders == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CarouselSlider(
            items: sliders!
                .map((slider) => SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () async {
                          if (slider.openProductId != null) {
                            homeController.goProduct(slider.openProductId!);
                          } else if (slider.openCategoryId != null) {
                            homeController
                                .goProductByCat(slider.openCategoryId!);
                          }
                        },
                        child: Card(
                          color: ColorManager.primaryColor,
                          elevation: AppSpacing.ap1_5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.ap12),
                              side: const BorderSide(
                                  color: ColorManager.darkColor,
                                  width: AppSpacing.ap4)),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.ap12),
                            child: CachedNetworkImage(
                              progressIndicatorBuilder: (context, url,
                                      downloadProgress) =>
                                  BuildCircularProgressIndicatorWithDownload(
                                      downloadProgress),
                              errorWidget: (context, url, error) =>
                                  const ErrorIcon(),
                              imageUrl: locale == "en"
                                  ? slider.imageEN
                                  : slider.imageAR,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            )),
      );
    }
  }
}

class _GetProducts extends StatelessWidget {
  final HomeController homeController;
  final FavController favController;
  final CartController cartController;

  final List<DataHomeModel> dataHome;
  const _GetProducts(
      {Key? key,
      required this.homeController,
      required this.dataHome,
      required this.favController,
      required this.cartController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String locale = Get.locale!.languageCode;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: homeController.homeModel.value?.data.dataHome.length ?? 0,
      itemBuilder: (context, indexCat) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildCategory(
              index: indexCat,
              mainCatModel: dataHome[indexCat].categoryModel,
              homeController: homeController),
          SizedBox(
            height: getDeviceType() == DeviceType.Tablet
                ? AppSize.ap350
                : AppSize.ap300,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indexPro) {
                return BuildProductItem(
                  cartController: cartController,
                  onTap: () {
                    goToProductDetails(
                        dataHome[indexCat].productModel[indexPro]);
                  },
                  productModel: dataHome[indexCat].productModel[indexPro],
                  locale: locale,
                  favWidget: AddToFavoriteButton(
                      favController: favController,
                      product: dataHome[indexCat].productModel[indexPro]),
                );
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
    );
  }
}
