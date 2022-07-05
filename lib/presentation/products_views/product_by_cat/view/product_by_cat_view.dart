import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/app/util/get_device_type.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';
import 'package:ms_store/presentation/products_views/product_by_cat/controller/product_by_cat_controller.dart';
import '../../../../gen/assets.gen.dart';
import '../../../components/products/components.dart';
import '../../../components/products/functions.dart';

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

  final CategoryDataModel categoryModel = Get.arguments['categoryData'];

  @override
  void initState() {
    _language = Get.locale!.languageCode;
    _productByCatController = Get.find();
    _cartController = Get.find();
    _favController = Get.find();
    _productByCatController.getData(categoryModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: const BackButton(),
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
      body: Obx(() => _productByCatController.flowState.value != null
          ? _productByCatController.flowState.value!.getScreenWidget(
              _GetContentWidget(
                  cartController: _cartController,
                  favController: _favController,
                  productByCatController: _productByCatController,
                  language: _language,
                  context: context), retryActionFunction: () {
              _productByCatController.getData(categoryModel.id);
            })
          : _GetContentWidget(
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
  final FavController favController;
  const _GetContentWidget({
    Key? key,
    required ProductByCatController productByCatController,
    required String language,
    required this.context,
    required this.cartController,
    required this.favController,
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
                child: Column(
                  children: [
                    Obx(() => GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Device.get().isTablet ? 3 : 2,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            childAspectRatio:
                                Device.get().isTablet ? 1 / 2.2 : 1 / 1.6,
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
                                      .productCatIdModel
                                      .value!
                                      .products[index])),
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
