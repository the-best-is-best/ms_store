import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/app/components/common/build_circular_progress_indicator.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/app/resources/icons_manger.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/app/util/get_device_type.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';
import 'package:ms_store/presentation/products_views/product_by_cat/controller/product_by_cat_controller.dart';
import '../../../../app/resources/routes_manger.dart';
import '../../../../gen/assets.gen.dart';
import '../../../components/products/components.dart';
import '../../../components/products/functions.dart';
import '../widgets/end_drawer.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({Key? key}) : super(key: key);

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat> {
  late final String _language;
  late final ProductByCatController _productByCatController;
  late final CartController _cartController;
  late final FavController _favController;
  final ScrollController _scrollController = ScrollController();
  final CategoryDataModel categoryModel = Get.arguments['categoryData'];
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _language = Get.locale!.languageCode;
    _productByCatController = Get.find();
    _productByCatController.setCatId(categoryModel.id);
    _cartController = Get.find();
    _favController = Get.find();
    _productByCatController.getData();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _productByCatController.getMoreProduct(_scrollController);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.filterRoute);
            },
            icon: Icon(
              IconsManger.filter,
              size: FontSize.s20,
            ),
          ),
        ],
        title: SizedBox(
          width: context.width,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '${AppStrings.productsCategory} ( ${_language == "ar" ? categoryModel.nameAR : categoryModel.nameEN} )',
              style: context.textTheme.bodyMedium!.copyWith(fontSize: null),
            ),
          ),
        ),
      ),
      //endDrawer: const EndDrawer(),
      body: Obx(() => _productByCatController.flowState.value != null
          ? _productByCatController.flowState.value!.getScreenWidget(
              _GetContentWidget(
                  scrollController: _scrollController,
                  cartController: _cartController,
                  favController: _favController,
                  productByCatController: _productByCatController,
                  language: _language,
                  context: context), retryActionFunction: () {
              _productByCatController.getData();
            })
          : _GetContentWidget(
              scrollController: _scrollController,
              cartController: _cartController,
              favController: _favController,
              productByCatController: _productByCatController,
              language: _language,
              context: context)),
    );
  }
}

class _GetContentWidget extends StatelessWidget {
  final CartController cartController;
  final ScrollController scrollController;
  final FavController favController;
  const _GetContentWidget({
    Key? key,
    required ProductByCatController productByCatController,
    required String language,
    required this.context,
    required this.cartController,
    required this.favController,
    required this.scrollController,
  })  : _productByCatController = productByCatController,
        _language = language,
        super(key: key);

  final ProductByCatController _productByCatController;
  final String _language;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BuildCondition(
        condition: _productByCatController
                .productCatIdModel.value?.products.isNotEmpty ??
            false,
        builder: (context) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: Colors.white,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Obx(() => GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            childAspectRatio:
                                getDeviceType() == DeviceType.Tablet
                                    ? 1 / 1
                                    : 1 / 1.6,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _productByCatController
                                  .productCatIdModel.value?.products.length ??
                              0,
                          itemBuilder: (_, int index) => BuildProductItem(
                            cartController: cartController,
                            locale: _language,
                            onTap: () {
                              goToProductDetails(_productByCatController
                                  .productCatIdModel.value!.products[index]);
                            },
                            productModel: _productByCatController
                                .productCatIdModel.value!.products[index],
                            favWidget: AddToFavoriteButton(
                                favController: favController,
                                product: _productByCatController
                                    .productCatIdModel.value!.products[index]),
                          ),
                        )),
                    Obx(() => BuildCondition(
                          condition:
                              _productByCatController.getMoreProducts.value,
                          builder: (_) => const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: AppSpacing.ap14),
                            child: SizedBox(
                              height: AppSize.ap30,
                              width: AppSize.ap30,
                              child: BuildCircularProgressIndicator(),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
        fallback: (_) => Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(const $AssetsJsonGen().empty, height: 300),
                Text(
                  AppStrings.noProducts,
                  style: context.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
