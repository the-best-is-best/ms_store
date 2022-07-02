import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/routes_manger.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/gen/assets.gen.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../../../../../app/components.dart';
import '../../../../../app/components/common/build_circular_progress_indicator.dart';
import '../../../../../app/di.dart';
import '../../../../../domain/models/store/category_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String locale = Get.locale!.languageCode;
  late final CategoryController _categoryController;
  @override
  void initState() {
    _categoryController = Get.find();
    _categoryController.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.categoryTitle,
          style: context.textTheme.displayLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(
                  Routes.searchRoute,
                );
              },
              icon: const Icon(IconsManger.search))
        ],
      ),
      body: Obx(() => _categoryController.flowState.value != null
          ? _categoryController.flowState.value!
              .getScreenWidget(_getContentWidget(), retryActionFunction: () {
              _categoryController.getData();
            })
          : _getContentWidget()),
    );
  }

  Widget _getContentWidget() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacing.ap8.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) => buildTitleCategories(index,
                        _categoryController.categoryModel.value!.data![index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.0.h,
                    ),
                    itemCount:
                        _categoryController.categoryModel.value?.data?.length ??
                            0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: ColorManager.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        AnimatedOpacity(
                          opacity:
                              _categoryController.selectedCategoryItem.value ==
                                      _categoryController.animateContainer.value
                                  ? 1
                                  : 0,
                          duration: const Duration(milliseconds: 250),
                          child: BuildCondition(
                            condition: _categoryController
                                    .categoryModel
                                    .value
                                    ?.data?[_categoryController
                                        .selectedCategoryItem.value]
                                    .childCat
                                    .isNotEmpty ??
                                false,
                            builder: (context) => GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _categoryController
                                      .categoryModel
                                      .value
                                      ?.data?[_categoryController
                                          .selectedCategoryItem.value]
                                      .childCat
                                      .length ??
                                  0,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1 / 2,
                              ),
                              itemBuilder: (context, index) => buildGridCat(
                                  _categoryController
                                      .categoryModel
                                      .value
                                      ?.data?[_categoryController
                                          .selectedCategoryItem.value]
                                      .childCat[index]),
                            ),
                            fallback: (context) => Column(
                              children: [
                                Lottie.asset(const $AssetsJsonGen().empty,
                                    width: 300.w),
                                Text(
                                  AppStrings.noProducts,
                                  style: context.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitleCategories(int index, CategoryDataWithChildModel data) {
    return Obx(
      () => AnimatedContainer(
        decoration: BoxDecoration(
          color: _categoryController.selectedCategoryItem.value == index
              ? ColorManager.darkColor
              : null,
        ),
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        child: TextButton(
          onPressed: () {
            _categoryController.selectCategoryItem(index);
          },
          child: Text(
            locale == "ar" ? data.nameAR : data.nameEN,
            style: _categoryController.selectedCategoryItem.value == index
                ? context.textTheme.labelMedium
                    ?.copyWith(color: ColorManager.greyLight)
                : context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildGridCat(CategoryDataModel? categoryModel) => InkWell(
        onTap: () {
          initProductByCatId();
          Get.toNamed(Routes.productByCatIdRoute,
              arguments: {'categoryData': categoryModel!});
        },
        child: Column(
          children: [
            CachedNetworkImage(
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  BuildCircularProgressIndicatorWithDownload(downloadProgress),
              errorWidget: (context, url, error) => const ErrorIcon(),
              imageUrl: categoryModel!.image,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 5.0),
            Flexible(
              child: Text(
                locale == "ar" ? categoryModel.nameAR : categoryModel.nameEN,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
}
