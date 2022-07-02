import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/components/common/input_field.dart';
import '../../../core/resources/icons_manger.dart';
import '../../../core/resources/strings_manager.dart';
import '../controller/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? searchTitle;

  late final SearchController searchController;
  late final TextEditingController searchTextEditingController;

  @override
  void initState() {
    searchController = Get.find();
    searchTextEditingController = TextEditingController();
    if (Get.arguments != null) {
      searchTextEditingController.text = Get.arguments['searchTitle'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: InputField(
            controller: searchTextEditingController,
            keyBoardType: TextInputType.text,
            label: AppStrings.search,
            prefixIcon: IconsManger.search,
          ),
        ),
      ),
    );
  }
}
