import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/icons_manger.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/gen/assets.gen.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../../../../../domain/models/store/category_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with WidgetsBindingObserver {
  String locale = Get.locale!.languageCode;
  late final CategoryController _categoryController;
  @override
  void initState() {
    _categoryController = Get.find();
    _categoryController.getData();

    super.initState();
  }

  @override
  void dispose() {
    _categoryController.categoryModel.value = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _categoryController.categoryModel.value = null;
    }
    if (state == AppLifecycleState.resumed) {
      _categoryController.getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.categoryTitle,
          style: themeData.textTheme.labelMedium,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(IconsManger.search))
        ],
      ),
      body: Obx(() => _categoryController.flowState.value != null
          ? _categoryController.flowState.value!.getScreenWidget(
              _getContentWidget(themeData), retryActionFunction: () {
              _categoryController.getData();
            })
          : _getContentWidget(themeData)),
    );
  }

  Widget _getContentWidget(ThemeData themeData) {
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
                    itemBuilder: (context, index) => buildTitleCategories(
                        themeData,
                        index,
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
            flex: 2,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 10,
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
                          SizedBox(
                            height: 20.0.h,
                          ),
                          Container(
                            color: Colors.white,
                            child: GridView.count(
                              shrinkWrap:
                                  true, //بقولة سيح مع باقي الصفحة كلها كلكو علي بعضوكو كونوا حاجة واحدة
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount:
                                  3, //الشبكة علي شكل مربعين جنب بعض كل ما هتزود كل ما عدد المربعات هتزيد
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1 / 2, //   العرض/الطول
                              children: List.generate(
                                _categoryController
                                        .categoryModel
                                        .value
                                        ?.data?[_categoryController
                                            .selectedCategoryItem.value]
                                        .childCat
                                        .length ??
                                    0,
                                (index) => buildGridCat(
                                    themeData,
                                    _categoryController
                                        .categoryModel
                                        .value
                                        ?.data?[_categoryController
                                            .selectedCategoryItem.value]
                                        .childCat[index]),
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

  Widget buildTitleCategories(
      ThemeData themeData, int index, CategoryDataWithChildModel data) {
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
            // add it here (m)
          },
          child: Text(
            locale == "ar" ? data.nameEN : data.nameEN,
            style: _categoryController.selectedCategoryItem.value == index
                ? themeData.textTheme.labelMedium
                    ?.copyWith(color: ColorManager.greyLight)
                : themeData.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }

  Widget buildGridCat(ThemeData themeData, CategoryDataModel? categoryModel) =>
      InkWell(
        // onTap: () =>
        //     navigateTo(context, ProductsByCat(categoryModel: categoryModel)),
        child: BuildCondition(
          condition: categoryModel != null,
          builder: (context) => Column(
            children: [
              Image(
                image: NetworkImage(categoryModel!.image),
                width: double.infinity.w,
                height: 100.h,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                locale == "ar" ? categoryModel.nameAR : categoryModel.nameEN,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: themeData.textTheme.labelSmall,
              ),
            ],
          ),
          fallback: (context) => Column(
            children: [
              Lottie.asset(const $AssetsJsonGen().empty),
              Text(
                AppStrings.noCategory,
                style: themeData.textTheme.labelSmall,
              )
            ],
          ),
        ),
      );
}
