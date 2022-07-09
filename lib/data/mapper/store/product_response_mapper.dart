import '../../../app/extensions.dart';
import '../../../domain/models/store/product_model.dart';
import '../../responses/store_responses/product_data_response.dart';
import '../../responses/store_responses/get_products_by_ids_responses.dart';

extension GetProductByIdsDataResponseMapper on GetProductByIdsDataResponse? {
  List<ProductModel> toDomain() {
    return this?.data?.map((e) => e.toDomain()).toList() ??
        const Iterable.empty().cast<ProductModel>().toList();
  }
}

extension ProductHomeResponseMapper on ProductDataResponse? {
  ProductModel toDomain() {
    return ProductModel(
        id: this?.id?.orEmpty() ?? 0,
        nameEN: this?.nameEN?.orEmpty() ?? "",
        nameAR: this?.nameAR?.orEmpty() ?? "",
        image: this?.image?.orEmpty() ?? "",
        price: this?.price?.orEmpty() ?? 0,
        priceAfterDis: this?.priceAfterDis?.orEmpty() ?? 0,
        descriptionEN: this?.descriptionEN?.orEmpty() ?? "",
        descriptionAR: this?.descriptionAR?.orEmpty() ?? "",
        categoryId: this?.categoryId?.orEmpty() ?? 0,
        offers: this?.offers?.orEmpty() ?? 0,
        stock: this?.stock?.orEmpty() ?? 0);
  }
}
