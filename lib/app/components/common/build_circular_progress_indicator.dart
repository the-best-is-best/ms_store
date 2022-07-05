import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/resources/color_manager.dart';

class BuildCircularProgressIndicatorWithDownload extends StatelessWidget {
  final DownloadProgress downloadProgress;
  const BuildCircularProgressIndicatorWithDownload(
    this.downloadProgress, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
          color: ColorManager.primaryColor, value: downloadProgress.progress),
    );
  }
}

class BuildCircularProgressIndicator extends StatelessWidget {
  const BuildCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(color: ColorManager.primaryColor));
  }
}
