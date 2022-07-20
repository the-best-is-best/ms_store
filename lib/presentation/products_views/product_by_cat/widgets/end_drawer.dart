import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/app/resources/values_manager.dart';
import 'package:ms_store/presentation/products_views/product_by_cat/controller/product_by_cat_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final String _language = Get.locale!.languageCode;
  final ProductByCatController _productByCatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Filter',
          style: context.textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.ap12),
        child: Column(
          children: [
            ExpandablePanel(
              header: Align(
                alignment:
                    _language == "ar" ? Alignment.topRight : Alignment.topLeft,
                child: Text(
                  AppStrings.price,
                  style: context.textTheme.labelLarge,
                ),
              ),
              collapsed: const SizedBox(),
              expanded: Obx(
                () => SizedBox(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.ap12),
                    child: SfRangeSlider(
                      activeColor: ColorManager.darkColor,
                      min: _productByCatController
                          .productCatIdModel.value?.minPrice,
                      max: _productByCatController
                          .productCatIdModel.value?.maxPrice,
                      onChanged: (SfRangeValues value) {
                        _productByCatController.sfRangeValues.value = value;
                      },
                      values: _productByCatController.sfRangeValues.value,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          width: .4.sw,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: ColorManager.white,
              side: const BorderSide(
                color: ColorManager.primaryColor,
                style: BorderStyle.solid,
              ),
            ),
            onPressed: () {
              context.back();
            },
            child: Text(
              'CLEAR',
              style: context.textTheme.labelMedium!
                  .copyWith(color: ColorManager.textColor),
            ),
          ),
        ),
        SizedBox(
          width: .4.sw,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('APPLY'),
          ),
        ),
      ]),
    );
  }
}
