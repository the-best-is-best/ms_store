import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/icons_manger.dart';
import 'package:ms_store/app/resources/routes_manger.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/app/resources/values_manager.dart';
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
                initProductBySearch();
                Get.toNamed(Routes.searchRoute);
              },
              icon: const Icon(IconsManger.search))
        ],
      ),
      body: Obx(() => _categoryController.flowState.value != null
          ? _categoryController.flowState.value!.getScreenWidget(
              _GetContentWidget(categoryController: _categoryController),
              retryActionFunction: () {
              _categoryController.getData();
            })
          : _GetContentWidget(categoryController: _categoryController)),
    );
  }
}

class _GetContentWidget extends StatelessWidget {
  final CategoryController categoryController;

  const _GetContentWidget({Key? key, required this.categoryController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.ap8,
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
                    itemBuilder: (context, index) => BuildTitleCategories(
                        categoryController: categoryController,
                        index: index,
                        data: categoryController
                            .categoryModel.value!.data![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                    itemCount:
                        categoryController.categoryModel.value?.data?.length ??
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
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          AnimatedOpacity(
                            opacity: categoryController
                                        .selectedCategoryItem.value ==
                                    categoryController.animateContainer.value
                                ? 1
                                : 0,
                            duration: const Duration(milliseconds: 250),
                            child: BuildCondition(
                              condition: categoryController
                                      .categoryModel
                                      .value
                                      ?.data?[categoryController
                                          .selectedCategoryItem.value]
                                      .childCat
                                      .isNotEmpty ??
                                  false,
                              builder: (context) => GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categoryController
                                        .categoryModel
                                        .value
                                        ?.data?[categoryController
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
                                itemBuilder: (context, index) => BuildGridCat(
                                    categoryModel: categoryController
                                        .categoryModel
                                        .value!
                                        .data![categoryController
                                            .selectedCategoryItem.value]
                                        .childCat[index]),
                              ),
                              fallback: (context) => Column(
                                children: [
                                  Lottie.asset(const $AssetsJsonGen().empty,
                                      width: 300),
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
          ),
        ],
      ),
    );
  }
}

class BuildTitleCategories extends StatelessWidget {
  final CategoryController categoryController;
  final int index;
  final CategoryDataWithChildModel data;

  const BuildTitleCategories(
      {Key? key,
      required this.categoryController,
      required this.index,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String locale = Get.locale!.languageCode;

    return Obx(
      () => AnimatedContainer(
        decoration: BoxDecoration(
          color: categoryController.selectedCategoryItem.value == index
              ? ColorManager.darkColor
              : null,
        ),
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        child: TextButton(
          onPressed: () {
            categoryController.selectCategoryItem(index);
          },
          child: Text(
            locale == "ar" ? data.nameAR : data.nameEN,
            style: categoryController.selectedCategoryItem.value == index
                ? context.textTheme.labelMedium
                    ?.copyWith(color: ColorManager.greyLight)
                : context.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class BuildGridCat extends StatelessWidget {
  final CategoryDataModel categoryModel;
  const BuildGridCat({Key? key, required this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String locale = Get.locale!.languageCode;

    return InkWell(
      onTap: () {
        initProductByCatId();
        Get.toNamed(Routes.productByCatIdRoute,
            arguments: {'categoryData': categoryModel});
      },
      child: Column(
        children: [
          CachedNetworkImage(
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                BuildCircularProgressIndicatorWithDownload(downloadProgress),
            errorWidget: (context, url, error) => const ErrorIcon(),
            imageUrl: categoryModel.image,
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
}
