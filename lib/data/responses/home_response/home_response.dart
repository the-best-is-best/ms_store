import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';
import 'data_in_home_response.dart';
import 'slider_response.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeDataResponseWithSlider {
  final List<SliderResponse>? slider;
  final List<DataInHomeResponse>? dataHome;

  HomeDataResponseWithSlider(this.slider, this.dataHome);
  factory HomeDataResponseWithSlider.fromJson(Map<String, dynamic> json) {
    return _$HomeDataResponseWithSliderFromJson(json);
  }
}

@JsonSerializable()
class HomeResponse extends BaseResponses {
  final HomeDataResponseWithSlider? data;

  HomeResponse(this.data);
  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return _$HomeResponseFromJson(json);
  }
}
