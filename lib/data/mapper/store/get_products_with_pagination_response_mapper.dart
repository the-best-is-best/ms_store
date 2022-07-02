import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/data/mapper/store/product_response_mapper.dart';
import 'package:ms_store/data/responses/store_responses/get_products_with_pagination_response.dart';
import 'package:ms_store/domain/models/store/product_with_pagination_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

extension ProductWithPaginationDataResponseMapper
    on ProductWithPaginationDataResponse? {
  ProductWithPaginationModel toDomain() {
    return ProductWithPaginationModel(
        products: this?.data?.products?.map((e) => e.toDomain()).toList() ??
            const Iterable.empty().cast<ProductModel>().toList(),
        totalPages: this?.data?.totalPages?.orEmpty() ?? 0);
  }
}
