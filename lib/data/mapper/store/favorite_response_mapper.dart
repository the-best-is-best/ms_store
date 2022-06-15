import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/data/responses/store_responses/favorite_response.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';

extension FavoriteDataResponseMapper on FavoriteDataResponse? {
  FavoriteDataModel toDomain() {
    return FavoriteDataModel(
        this?.id?.orEmpty() ?? 0,
        this?.productId?.orEmpty() ?? 0,
        this?.status != null && this?.status == 1 ? true : false);
  }
}

extension FavoriteGetResponseMapper on FavoriteGetResponse? {
  FavoriteModel toDomain() {
    List<FavoriteDataModel> favoriteData = this
            ?.data
            ?.map((e) => e.toDomain())
            .cast<FavoriteDataModel>()
            .toList() ??
        const Iterable.empty().cast<FavoriteDataModel>().toList();
    return FavoriteModel(favoriteData);
  }
}
