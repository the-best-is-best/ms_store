import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

Widget addToCartButton(int productId) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: null,
      child: Text(AppStrings.addToCartButton),
    ),
  );
}
