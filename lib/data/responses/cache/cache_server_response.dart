import 'package:json_annotation/json_annotation.dart';
import 'package:ms_store/data/responses/base/base_response.dart';
part 'cache_server_response.g.dart';

@JsonSerializable()
class CacheServerDataResponse {
  final String? cacheKeyServer;

  CacheServerDataResponse(this.cacheKeyServer);

  factory CacheServerDataResponse.fromJson(Map<String, dynamic> json) {
    return _$CacheServerDataResponseFromJson(json);
  }
}

@JsonSerializable()
class CacheServerResponse extends BaseResponses {
  final CacheServerDataResponse? data;
  CacheServerResponse(this.data);

  factory CacheServerResponse.fromJson(Map<String, dynamic> json) {
    return _$CacheServerResponseFromJson(json);
  }
}
