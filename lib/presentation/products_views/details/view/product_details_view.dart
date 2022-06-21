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
      // appBar: AppBar(
      //   title: Text(
      //     language == "ar" ? widget.product.nameAR : widget.product.nameEN,
      //     style: context.textTheme.titleMedium,
      //   ),
      //   actions: [
      //     addToFavoriteButton(() {}, widget.product.id),
      //   ],
      //   leading: buttonBack(),
      // ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: .6.sh,
                title: Text(
                    language == "ar"
                        ? widget.product.nameAR
                        : widget.product.nameEN,
                    style: context.textTheme.titleMedium),
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
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
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppSize.ap12, right: AppSize.ap14),
                    child: addToFavoriteButton(() {}, widget.product.id),
                  ),
                ],
                leading: buttonBack(),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
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
            ],
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: context.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildPrice(widget.product),
                  AddToCartButton(widget.product, ColorManager.greyLight),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
