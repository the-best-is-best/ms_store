import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/data/mapper/store/product_response_mapper.dart';
import 'package:ms_store/data/responses/store_responses/get_products_by_cat_id_response.dart';
import 'package:ms_store/domain/models/store/product_cat_id_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

extension GetProductCatIdResponseMapper on GetProductCatIdDataResponse? {
  ProductCatIdModel toDomain() {
    return ProductCatIdModel(
        this?.data?.products?.map((e) => e.toDomain()).toList() ??
            const Iterable.empty().cast<ProductModel>().toList(),
        this?.data?.totalPages?.orEmpty() ?? 0);
  }
}
