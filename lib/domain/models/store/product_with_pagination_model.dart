import 'package:ms_store/domain/models/store/product_model.dart';

class ProductWithPaginationModel {
  final List<ProductModel> products;
  final int totalPages;
  final num minPrice;
  final num maxPrice;

  ProductWithPaginationModel({
    required this.products,
    required this.totalPages,
    required this.minPrice,
    required this.maxPrice,
  });
}
