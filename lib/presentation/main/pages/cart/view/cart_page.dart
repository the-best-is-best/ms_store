import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/domain/models/store/product_model.dart';
import 'package:ms_store/gen/assets.gen.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';

import '../../../../../core/resources/strings_manager.dart';
import '../../../../../domain/models/store/cart_model.dart';

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
        condition: _cartController.productsInCart.isNotEmpty,
        builder: (_) => ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            color: Colors.white,
            axisDirection: AxisDirection.down,
            child: Column(
              children: [],
            ),
          ),
        ),
        fallback: (_) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(const $AssetsJsonGen().empty, width: 300.w),
              Text(
                AppStrings.noProducts,
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//   Widget buildCartItem(CartModel cart) => Builder(builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ConditionalBuilder(
//                 condition: state is! CartLoadingState,
//                 builder: (context) {
//                   return IconButton(
//                     icon: Icon(
//                       Icons.delete_forever,
//                       color: Colors.red,
//                     ),
//                     onPressed: () async {
//                       await ShopCubit.get(context).deleteFromCart(
//                           LoginCubit.get(context).loginModel!.data!.id!,
//                           cart.productId!);
//                       ShopCubit.get(context).totalPrice = null;
//                     },
//                   );
//                 },
//                 fallback: (_) => Center(
//                     child: CircularProgressIndicator(
//                   color: Color.fromRGBO(115, 42, 126, 0.8),
//                 )),
//               ),
//               Container(
//                 width: 170.w,
//                 height: 170.h,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: CachedNetworkImage(
//                     imageUrl: productData.image!,
//                     fit: BoxFit.contain,
//                     progressIndicatorBuilder:
//                         (context, url, downloadProgress) => Center(
//                       child: CircularProgressIndicator(
//                           color: Color.fromRGBO(115, 42, 126, 0.8),
//                           value: downloadProgress.progress),
//                     ),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: 10.0.r,
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 150.w,
//                       child: Text(
//                         LanguageCubit.get(context).isArabic
//                             ? productData.nameAR!
//                             : productData.nameEN!,
//                         style: TBIBFontStyle.h3.copyWith(
//                           fontSize: 20.0.sp,
//                           color: Colors.black,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5.0.h,
//                     ),
//                     Text(
//                       productData.priceAfterDes == 0
//                           ? productData.price.toString()
//                           : productData.priceAfterDes.toString(),
//                       style: TBIBFontStyle.h2.copyWith(
//                         fontSize: 25.0.sp,
//                         color: Color.fromRGBO(115, 42, 126, 1.0),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0.h,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: Row(
//                         children: [
//                           ConditionalBuilder(
//                             condition: state is! CartLoadingState,
//                             builder: (context) {
//                               return IconButton(
//                                 onPressed: () async {
//                                   await ShopCubit.get(context).changeQuantity(
//                                       cart.productId!,
//                                       LoginCubit.get(context)
//                                           .loginModel!
//                                           .data!
//                                           .id!,
//                                       quan: cart.quantity! - 1);
//                                   ShopCubit.get(context).totalPrice = null;
//                                 },
//                                 icon: Icon(
//                                   Icons.remove,
//                                   color: Color.fromRGBO(115, 42, 126, 1.0),
//                                 ),
//                               );
//                             },
//                             fallback: (_) => Center(
//                               child: Center(
//                                 child: CircularProgressIndicator(
//                                   color: Color.fromRGBO(115, 42, 126, 0.8),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Text(
//                             cart.quantity.toString(),
//                             style: TBIBFontStyle.h2.copyWith(
//                               fontSize: 27.0.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromRGBO(115, 42, 126, 1.0),
//                             ),
//                           ),
//                           ConditionalBuilder(
//                             condition: state is! CartLoadingState,
//                             builder: (context) {
//                               return IconButton(
//                                 onPressed: () async {
//                                   await ShopCubit.get(context).changeQuantity(
//                                       cart.productId!,
//                                       LoginCubit.get(context)
//                                           .loginModel!
//                                           .data!
//                                           .id!,
//                                       quan: cart.quantity! + 1);
//                                   ShopCubit.get(context).totalPrice = null;
//                                 },
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Color.fromRGBO(115, 42, 126, 1.0),
//                                 ),
//                               );
//                             },
//                             fallback: (_) => Center(
//                               child: CircularProgressIndicator(
//                                 color: Color.fromRGBO(115, 42, 126, 0.8),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       });
// }
