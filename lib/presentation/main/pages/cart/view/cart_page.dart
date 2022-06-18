import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';

import '../../../../../core/resources/strings_manager.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartController _cartController;
  @override
  void initState() {
    _cartController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.cartTitle,
          style: context.textTheme.displayLarge,
        ),
      ),
      body: BuildCondition(
        condition: !_cartController.cartModel.isNotEmpty,
        builder: (_) => Container(),
        fallback: (_) => Center(
          child: Text(
            AppStrings.noProducts,
            style: context.textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
