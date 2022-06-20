import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/resources/strings_manager.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.favTitle,
          style: context.textTheme.displayLarge,
        ),
      ),
    );
  }
}
