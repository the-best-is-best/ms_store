import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/components/common/input_field.dart';
import '../../../core/resources/icons_manger.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/util/get_device_type.dart';
import '../../components/products/components.dart';
import '../../components/products/functions.dart';
import '../controller/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? searchText;

  late final SearchController _searchController;
  late final TextEditingController _searchTextEditingController;

  @override
  void initState() {
    _searchController = Get.find();
    _searchTextEditingController = TextEditingController();
    if (Get.arguments != null) {
      _searchTextEditingController.text = Get.arguments['searchText'];
      _searchController.search(_searchTextEditingController.text);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: InputField(
            controller: _searchTextEditingController,
            keyBoardType: TextInputType.text,
            label: AppStrings.search,
            prefixIcon: IconsManger.search,
            onEditingComplete: () {
              _searchController.search(_searchTextEditingController.text);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: AppSpacing.ap8, right: AppSpacing.ap8),
          child: Obx(
            () => _searchController.flowState.value != null
                ? _searchController.flowState.value!.getScreenWidget(
                    _GetContentWidget(
                      searchController: _searchController,
                    ), retryActionFunction: () {
                    _searchController.search(_searchTextEditingController.text);
                  })
                : BuildCondition(
                    condition: _searchController.productSearch.value != null,
                    builder: (context) {
                      return _GetContentWidget(
                          searchController: _searchController);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class _GetContentWidget extends StatelessWidget {
  final SearchController searchController;
  const _GetContentWidget({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _language = Get.locale!.languageCode;
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Device.get().isTablet ? 3 : 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio:
                          Device.get().isTablet ? 1 / 2.2 : 1 / 1.6,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        searchController.productSearch.value?.products.length ??
                            0,
                    itemBuilder: (_, int index) => BuildProductItem(
                        locale: _language,
                        onTap: () {
                          goToProductDetails(searchController
                              .productSearch.value!.products[index]);
                        },
                        productModel: searchController
                            .productSearch.value!.products[index],
                        favWidget: AddToFavoriteButton(
                            product: searchController
                                .productSearch.value!.products[index])),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
