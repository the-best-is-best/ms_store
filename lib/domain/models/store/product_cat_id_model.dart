import 'package:ms_store/domain/models/store/product_model.dart';

class ProductCatIdModel {
  final List<ProductModel> products;
  final int totalPages;

  ProductCatIdModel(this.products, this.totalPages);
}
