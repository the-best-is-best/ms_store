import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/resources/icons_manger.dart';
import '../../../presentation/products_views/details/controller/product_details_controller.dart';
import '../common/input_field.dart';

class CommentDialog extends StatefulWidget {
  const CommentDialog({Key? key}) : super(key: key);

  @override
  State<CommentDialog> createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  late final TextEditingController commentTextEditingController;
  late final ProductDetailsController productDetailsController;
  @override
  void initState() {
    commentTextEditingController = TextEditingController();

    productDetailsController = Get.find();
    commentTextEditingController.text =
        productDetailsController.userReview.value?.comment ?? "";
    productDetailsController.addComment(commentTextEditingController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: commentTextEditingController,
      label: 'Tell us your experience ',
      keyBoardType: TextInputType.text,
      prefixIcon: IconsManger.comments,
      onChanged: (String? value) {
        productDetailsController.addComment(value ?? "");
      },
    );
  }
}
