import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/products_views/product_by_cat/controller/product_by_cat_controller.dart';

import '../../../../gen/assets.gen.dart';
import '../../../components/products/components.dart';
import '../../../components/products/functions.dart';

class ProductByCat extends StatefulWidget {
  final CategoryDataModel categoryModel = Get.arguments['categoryData'];

  ProductByCat({Key? key}) : super(key: key);

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat> {
  late final String _language;
  late final ProductByCatController _productByCatController;
  @override
  void initState() {
    _language = Get.locale!.languageCode;
    _productByCatController = Get.find();
    _productByCatController.getData(widget.categoryModel.id);
    super.initState();
  }

  Widget _getContentWidget() {
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
                          itemBuilder: (_, int index) => buildProductsItem(
                              context: context,
                              locale: _language,
                              onTap: () {
                                goToProductDetails(_productByCatController
                                    .productCatIdModel.value!.products[index]);
                              },
                              productModel: _productByCatController
                                  .productCatIdModel.value!.products[index],
                              favWidget: AddToFavoriteButton(
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
                Lottie.asset(const $AssetsJsonGen().empty, height: 300.h),
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
              '${AppStrings.productsCategory} ( ${_language == "ar" ? widget.categoryModel.nameAR : widget.categoryModel.nameEN} )',
            ),
          ),
        ),
      ),
      body: Obx(() => _productByCatController.flowState.value != null
          ? _productByCatController.flowState.value!
              .getScreenWidget(_getContentWidget(), retryActionFunction: () {
              _productByCatController.getData(widget.categoryModel.id);
            })
          : _getContentWidget()),
    );
  }
}
