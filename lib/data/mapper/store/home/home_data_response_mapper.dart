import 'main_cat_response_mapper.dart';
import 'slider_response_mapper.dart';
import '../product_response_mapper.dart';

import '../../../../domain/models/home_models/data_home_model.dart';
import '../../../../domain/models/home_models/home_data_model.dart';
import '../../../../domain/models/home_models/product_model_home.dart';
import '../../../../domain/models/home_models/slider_model.dart';
import '../../../responses/home_response/data_in_home_response.dart';
import '../../../responses/home_response/home_response.dart';

extension HomeResponseMapper on HomeResponse? {
  HomeModel toDomain() {
    List<SliderModel> slider = (this
                ?.data
                ?.slider
                ?.map((sliderResponse) => sliderResponse.toDomain()) ??
            const Iterable.empty())
        .cast<SliderModel>()
        .toList();
    List<DataInHomeResponse> dataInHomeResponse =
        (this?.data?.dataHome?.map((mainResponse) => mainResponse) ??
                const Iterable.empty())
            .cast<DataInHomeResponse>()
            .toList();

    List<DataHomeModel> dataHome = [];
    for (DataInHomeResponse data in dataInHomeResponse) {
      List<ProductModeHome> products =
          (data.productsInCategory?.map((product) => product.toDomain()))!
              .cast<ProductModeHome>()
              .toList();
      dataHome.add(DataHomeModel(data.category.toDomain(), products));
    }

    HomeDataModel data = HomeDataModel(slider: slider, dataHome: dataHome);

    return HomeModel(data);
  }
}
