import 'package:get/state_manager.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/domain/use_case/store/category_use_case.dart';
import 'package:ms_store/presentation/base/base_controller.dart';

import '../../../../../app/components.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class CategoryController extends GetxController with BaseController {
  final CategoryUseCase _categoryUseCase;
  Rxn<CategoryModel> categoryModel = Rxn<CategoryModel>();

  CategoryController(this._categoryUseCase);

  void getData() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var result = await _categoryUseCase.execute(null);
    await waitStateChanged(duration: 1800);
    result.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (categoryObject) {
      categoryModel.value = categoryObject;
      if (categoryModel.value == null) {
        flowState.value = EmptyState(message: AppStrings.noCategory);
      } else {
        flowState.value = ContentState();
      }
    });
  }

  RxInt selectedCategoryItem = 0.obs;
  RxInt animateContainer = 0.obs;
  void selectCategoryItem(int index) async {
    animateContainer.value = index;
    await waitStateChanged(duration: 500);
    selectedCategoryItem.value = index;
  }
}
