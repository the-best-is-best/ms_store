import 'package:flutter/material.dart';

class BuildLogo extends StatelessWidget {
  final double? logoHeight;
  final bool isDark;
  const BuildLogo({Key? key, this.logoHeight, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage("assets/images/logo_in_light.png"),
      fit: BoxFit.cover,
      height: logoHeight ?? 100,
    );
  }
}
