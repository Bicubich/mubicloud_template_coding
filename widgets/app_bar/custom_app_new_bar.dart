import 'package:flutter/material.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

// ignore: must_be_immutable
class CustomAppNewBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppNewBar({
    Key? key,
    required this.height,
    required this.leadingWidget,
    required this.titleText,
    this.centerTitle = false,
    this.actions,
    this.onTap,
    this.styleType,
  }) : super(
          key: key,
        );

  final double height;
  final Widget leadingWidget;
  final String titleText;
  final bool centerTitle;
  final List<Widget>? actions;
  final VoidCallback? onTap;
  final Style? styleType;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: UIConstants().bgColor,
      foregroundColor: appTheme.fgColor,
      leadingWidth: getHorizontalSize(56),
      leading: leadingWidget,
      title: Text(titleText),
      centerTitle: centerTitle,
      actions: actions,
      flexibleSpace: _getStyle(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  Container? _getStyle() {
    switch (styleType) {
      case Style.bgFill:
        return Container(
          height: getVerticalSize(56),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: UIConstants().bgColor,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFill,
}
