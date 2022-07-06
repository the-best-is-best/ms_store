import 'package:json_annotation/json_annotation.dart';

import '../base/base_response.dart';

part 'responses_update_user_data.g.dart';

@JsonSerializable()
class UpdateUserDataResponses extends BaseResponses {
  UpdateUserDataResponses();
  factory UpdateUserDataResponses.fromJson(Map<String, dynamic> json) {
    return _$UpdateUserDataResponsesFromJson(json);
  }
}
