import 'package:flutter/material.dart';

import 'custom_image_view.dart';

class CustomBlendSvg extends StatelessWidget {
  final Color blendColor;
  final double blendWidth;

  ///[imagePath] is required parameter for showing png,jpg,etc image
  String? imagePath;
  double? height;
  double? width;
  EdgeInsetsGeometry? margin;

  CustomBlendSvg({
    required this.blendColor,
    this.blendWidth = 0.0,
    required this.imagePath,
    this.margin,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImageView(svgPath: imagePath, margin: margin),
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: blendWidth,
            child: CustomImageView(
              svgPath: imagePath,
              color: blendColor,
              colorBlendMode: true,
              margin: margin,
            ),
          ),
        ),
      ],
    );
  }
}
