import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.alignment,
    this.margin,
    this.width,
    this.height,
    this.padding,
    this.decoration,
    this.child,
    this.onTap,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final EdgeInsetsGeometry? margin;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: iconButtonWidget,
          )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: IconButton(
          visualDensity: VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          iconSize: getHorizontalSize(height ?? 0),
          padding: EdgeInsets.all(0),
          icon: Container(
            alignment: Alignment.center,
            width: getHorizontalSize(width ?? 0),
            height: getVerticalSize(height ?? 0),
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: UIConstants().textColor.withOpacity(0.46),
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}

/// Extension on [CustomIconButton] to facilitate inclusion of all types of border style etc
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          22.r,
        ),
      );
  static BoxDecoration get fillDeeppurpleA200 => BoxDecoration(
        color: appTheme.deepPurpleA200,
        borderRadius: BorderRadius.circular(
          32.r,
        ),
      );
  static BoxDecoration get fillGreenA700 => BoxDecoration(
        color: appTheme.greenA700,
        borderRadius: BorderRadius.circular(
          35.r,
        ),
      );
  static BoxDecoration get fillLightgreenA700 => BoxDecoration(
        color: appTheme.lightGreenA700,
        borderRadius: BorderRadius.circular(
          35.r,
        ),
      );
  static BoxDecoration get fillLightblue400 => BoxDecoration(
        color: appTheme.lightBlue400,
        borderRadius: BorderRadius.circular(
          35.r,
        ),
      );
  static BoxDecoration get fillSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(
          35.r,
        ),
      );
  static BoxDecoration get fillBlue600 => BoxDecoration(
        color: appTheme.blue600,
        borderRadius: BorderRadius.circular(
          35.r,
        ),
      );
  static BoxDecoration get fillPrimaryTL14 => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          14.r,
        ),
      );
}
