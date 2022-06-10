import 'package:get/get.dart';

import '../../../../../domain/models/home_models/data_home_model.dart';
import '../../../../../domain/models/home_models/slider_model.dart';
import '../../../../../domain/use_case/home_use_case.dart';
import '../../../../base/base_controller.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/strings_manager.dart';

class HomeController extends GetxController with BaseController {
  final HomeUseCase _homeUseCase;
  HomeController(this._homeUseCase);
  RxList<SliderModel> sliderModel = <SliderModel>[].obs;
  RxList<DataHomeModel> dataHome = <DataHomeModel>[].obs;
  @override
  void onInit() {
    startFlow();
    super.onInit();
  }

  @override
  void onReady() async {
    await getHomeData();
    super.onReady();
  }

  Future getHomeData() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,
        message: AppStrings.loading);
    var resultHome = await _homeUseCase.execute(null);
    //  await waitStateChanged(duration: 1800);

    resultHome.fold((failure) {
      flowState.value = ErrorState(
          stateRendererType: StateRendererType.FULLSCREEN_ERROR_STATE,
          message: failure.messages);
    }, (homeObject) {
      sliderModel.value = homeObject.data.slider;
      dataHome.value = homeObject.data.dataHome;
      if (sliderModel.isEmpty || dataHome.isEmpty) {
        flowState.value = EmptyState(message: AppStrings.noProducts);
      } else {
        flowState.value = ContentState();
      }
    });
  }
}