import 'package:ms_store/domain/models/store/product_model.dart';

class ProductWithPaginationModel {
  final List<ProductModel> products;
  final int totalPages;

  ProductWithPaginationModel(
      {required this.products, required this.totalPages});
}
