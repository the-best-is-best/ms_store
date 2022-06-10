import 'package:hive_flutter/adapters.dart';

import 'data_home_model.dart';
import 'slider_model.dart';
part 'home_data_model.g.dart';

class HomeDataModel {
  final List<SliderModel> slider;
  final List<DataHomeModel> dataHome;

  HomeDataModel({
    required this.slider,
    required this.dataHome,
  });
}

@HiveType(typeId: 1)
class HomeModel {
  @HiveField(0)
  final HomeDataModel data;

  HomeModel(this.data);
}
