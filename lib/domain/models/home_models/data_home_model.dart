import 'package:hive/hive.dart';

import '../store/category_model.dart';
import '../store/product_model.dart';
part 'data_home_model.g.dart';

@HiveType(typeId: 4)
class DataHomeModel {
  @HiveField(0)
  final CategoryModel categoryModel;
  @HiveField(1)
  final List<ProductModel> productModel;

  DataHomeModel(this.categoryModel, this.productModel);
}
