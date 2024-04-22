import 'package:flutter/material.dart';
import 'package:mubicloud/core/app_export.dart';

// ignore: must_be_immutable
class AppbarImage extends StatelessWidget {
  AppbarImage({
    Key? key,
    this.height,
    this.width,
    this.imagePath,
    this.svgPath,
    this.icon,
    this.iconWidget,
    this.color,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  double? height;

  double? width;

  String? imagePath;

  String? svgPath;

  Color? color;
  IconData? icon;

  Widget? iconWidget;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTap?.call();
      },
      enableFeedback: false,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: iconWidget ??
            (icon == null
                ? CustomImageView(
                    svgPath: svgPath,
                    imagePath: imagePath,
                    height: height,
                    color: color,
                    width: width,
                    //fit: BoxFit.scaleDown,
                  )
                : Icon(
                    icon,
                    color: color,
                    size: width,
                  )),
      ),
    );
  }
}
