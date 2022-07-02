import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/product_with_pagination_model.dart';
import 'package:ms_store/presentation/base/base_controller.dart';

import '../../../../app/components.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../domain/use_case/store/get_product_by_cat_id_use_case.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

class ProductByCatController extends GetxController with BaseController {
  final GetProductByCatIdUseCase _getProductByCatIdUseCase;
  ProductByCatController(this._getProductByCatIdUseCase);
  Rx<ProductWithPaginationModel?> productCatIdModel =
      Rx<ProductWithPaginationModel?>(null);

  void getData(int catId) async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _getProductByCatIdUseCase
        .execute(GetProductByCatIdUseCaseInput(catId));

    await waitStateChanged();

    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (data) async {
      productCatIdModel.value = data;

      flowState.value = ContentState();
    });
  }
}
