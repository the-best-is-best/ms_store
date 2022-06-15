import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/domain/models/cache/cache_data.dart';

import '../../responses/cache/cache_server_response.dart';

extension CacheServer on CacheServerResponse? {
  CheckCachedDataServer toDomain() {
    CheckCachedServer cachedServer =
        CheckCachedServer(this?.data?.cacheKeyServer?.orEmpty() ?? "");
    return CheckCachedDataServer(cachedServer);
  }
}
