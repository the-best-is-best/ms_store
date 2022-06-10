import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../app/components.dart';

import '../pages/cart/view/cart_page.dart';
import '../pages/category/view/category_page.dart';
import '../pages/fav/view/fav_page.dart';
import '../pages/home/view/home_page.dart';
import '../pages/settings/view/settings_page.dart';

class MainViewController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxDouble opacity = 1.0.obs;
  Map<int, Map<String, dynamic>> pages = {
    0: {"page": const HomePage(), "pageTitle": "Home"},
    1: {"page": const CategoryPage(), "pageTitle": "Category"},
    2: {"page": const CartPage(), "pageTitle": "Cart"},
    3: {"page": const FavPage(), "pageTitle": "Favorite"},
    4: {"page": const SettingsPage(), "pageTitle": "Settings"}
  };

  void changeCurrentIndex(int index) async {
    if (index != currentIndex.value) {
      opacity.value = 0;
      await waitStateChanged(duration: 250);
      currentIndex.value = index;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        opacity.value = 1;
      });
    }
  }
}
