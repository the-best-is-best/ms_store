import 'data_home_model.dart';
import 'slider_model.dart';

class HomeDataModel {
  final List<SliderModel> slider;
  final List<DataHomeModel> dataHome;

  HomeDataModel({
    required this.slider,
    required this.dataHome,
  });
}

class HomeModel {
  final HomeDataModel data;

  HomeModel(this.data);
}
