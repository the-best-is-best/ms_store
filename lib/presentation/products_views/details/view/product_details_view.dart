import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/values_manager.dart';
import 'package:ms_store/core/util/get_device_type.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:expandable/expandable.dart';
import 'package:ms_store/presentation/components/products/components.dart';

import '../../../../app/components.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product = Get.arguments['product'];
  ProductDetailsView({Key? key}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final String language;

  @override
  void initState() {
    language = Get.locale!.languageCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          language == "ar" ? widget.product.nameAR : widget.product.nameEN,
          style: context.textTheme.titleMedium,
        ),
        actions: [
          addToFavoriteButton(() {}, widget.product.id),
        ],
        leading: buttonBack(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.ap8),
        child: Stack(
          children: [
            SizedBox(
              height: context.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.ap8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.image,
                          height: .5.sh,
                          fit: BoxFit.contain,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child:
                                      buildCircularProgressIndicatorWithDownload(
                                          downloadProgress)),
                          errorWidget: (context, url, error) => errorIcon(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    Text(
                      language == "ar"
                          ? widget.product.nameAR
                          : widget.product.nameEN,
                      style: context.textTheme.labelMedium,
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    ExpandableNotifier(
                      child: ExpandablePanel(
                        header: Icon(Icons.abc),
                        collapsed: Text(
                          language == "ar"
                              ? widget.product.descriptionAR
                              : widget.product.descriptionEN,
                          overflow: TextOverflow.ellipsis,
                          maxLines: Device.get().isTablet ? 4 : 2,
                          softWrap: true,
                          style: context.textTheme.labelSmall,
                        ),
                        expanded: Text(
                          language == "ar"
                              ? widget.product.descriptionAR
                              : widget.product.descriptionEN,
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    buildPrice(widget.product),
                    AddToCartButton(widget.product, ColorManager.greyLight)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
