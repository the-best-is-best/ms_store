import 'package:ms_store/data/responses/base/base_response.dart';

import 'package:json_annotation/json_annotation.dart';

part 'get_about_data_response.g.dart';

@JsonSerializable()
class GetAboutDataResponse extends BaseResponses {
  final GetAboutResponse? data;

  GetAboutDataResponse(this.data);
  factory GetAboutDataResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAboutDataResponseFromJson(json);
  }
}

@JsonSerializable()
class GetAboutResponse {
  final String? textEN;
  final String? textAR;
  factory GetAboutResponse.fromJson(Map<String, dynamic> json) {
    return _$GetAboutResponseFromJson(json);
  }

  GetAboutResponse(this.textEN, this.textAR);
}
