import 'package:get/get.dart';

import '../common/state_renderer/state_renderer_impl.dart';

mixin BaseController {
  Rxn<FlowState> flowState = Rxn<FlowState>();

  void startFlow() {
    flowState.value = ContentState();
  }
}
