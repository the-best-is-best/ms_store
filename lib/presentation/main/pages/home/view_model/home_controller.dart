import 'package:get/get.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';

import '../../../../../app/components.dart';
import '../../../../../domain/models/home_models/home_data_model.dart';
import '../../../../../domain/use_case/home_use_case.dart';
import '../../../../base/base_controller.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../controller/main_view_controller.dart';

class HomeController extends GetxController with BaseController {
  final HomeUseCase _homeUseCase;
  HomeController(this._homeUseCase);
  Rxn<HomeModel> homeModel = Rxn<HomeModel>();

  Future getHomeData() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var resultHome = await _homeUseCase.execute(null);
    await waitStateChanged(duration: 1800);

    resultHome.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (homeObject) {
      homeModel.value = homeObject;
      if (homeModel.value == null) {
        flowState.value = EmptyState(message: AppStrings.noProducts);
      } else {
        flowState.value = ContentState();
      }
    });
  }

  void goCategory(int index) {
    CategoryController categoryController = Get.find();
    categoryController.selectedCategoryItem.value = index;
    MainViewController mainViewController = Get.find();
    mainViewController.currentIndex.value = 1;
  }
}
