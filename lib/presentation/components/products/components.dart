import 'package:flutter/material.dart';
import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/presentation/main/pages/home/view_model/home_controller.dart';

import '../../../core/resources/strings_manager.dart';
import '../../../core/util/get_device_type.dart';

Widget addToCartButton(int productId) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      child: Text(AppStrings.addToCartButton),
    ),
  );
}

Widget addToFavoriteButton(Function() onPressed) {
  return Positioned(
    top: 20,
    right: 20,
    child: CircleAvatar(
      radius: Device.get().isTablet ? 40 : 27,
      backgroundColor: Colors.grey[400],
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          //  inFav == 1
          //   ? Icons.favorite_sharp
          Icons.favorite_border_outlined,
          // color: inFav == 1 ? Colors.red : Colors.white,
          color: Colors.white,
          size: Device.get().isTablet ? 40 : 33.0,
        ),
      ),
    ),
  );
}
