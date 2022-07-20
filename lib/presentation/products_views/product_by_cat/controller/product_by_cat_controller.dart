import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_with_pagination_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../app/components.dart';
import '../../../../app/resources/strings_manager.dart';
import '../../../../domain/use_case/store/get_product_by_cat_id_use_case.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

class ProductByCatController extends GetxController with BaseController {
  final GetProductByCatIdUseCase _getProductByCatIdUseCase;
  ProductByCatController(this._getProductByCatIdUseCase);
  Rx<ProductWithPaginationModel?> productCatIdModel =
      Rx<ProductWithPaginationModel?>(null);
  int page = 1;
  Rx<num?> minPrice = Rx<num?>(null);
  Rx<num?> maxPrice = Rx<num?>(null);
  Rx<SfRangeValues> sfRangeValues =
      Rx<SfRangeValues>(const SfRangeValues(0, 1));
  late int catId;
  void setCatId(int setCatId) {
    catId = setCatId;
  }

  void getData() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _getProductByCatIdUseCase.execute(
        GetProductByCatIdUseCaseInput(catId,
            currentPage: page,
            minPrice: minPrice.value,
            maxPrice: maxPrice.value));

    await waitStateChanged();

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      productCatIdModel.value = data;
      sfRangeValues.value = SfRangeValues(data.minPrice, data.maxPrice);
      flowState.value = ContentState();
    });
  }

  RxBool getMoreProducts = false.obs;

  void getMoreProduct(ScrollController _scrollController) async {
    if (productCatIdModel.value?.totalPages != page) {
      page++;
      getMoreProducts.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150), curve: Curves.ease);
      });
      var result = await _getProductByCatIdUseCase.execute(
          GetProductByCatIdUseCaseInput(catId,
              currentPage: page,
              minPrice: minPrice.value,
              maxPrice: maxPrice.value));

      await waitStateChanged();

      result.fold((failure) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
            message: failure.messages);
      }, (data) async {
        productCatIdModel.value?.products.addAll(data.products);

        flowState.value = ContentState();
      });
      getMoreProducts.value = false;
    }
  }
}
