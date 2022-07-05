import 'package:get/get.dart';
import 'package:ms_store/domain/use_case/store/get_products_by_search_use_case.dart';
import 'package:ms_store/presentation/base/base_controller.dart';

import '../../../app/components.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../domain/models/store/product_with_pagination_model.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class SearchController extends GetxController with BaseController {
  final GetProductsBySearchUseCase _getProductsBySearchUseCase;
  Rx<ProductWithPaginationModel?> productSearch =
      Rx<ProductWithPaginationModel?>(null);

  SearchController(this._getProductsBySearchUseCase);

  void search(String name) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _getProductsBySearchUseCase
        .execute(GetProductsBySearchUseCaseInput(name));
    await waitStateChanged();

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      productSearch.value = data;
      print(productSearch.value?.products.length);
      flowState.value = ContentState();
    });
  }
}
