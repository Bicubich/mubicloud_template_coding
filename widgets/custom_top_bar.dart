import 'package:flutter/material.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

import 'app_bar/appbar_title.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  CustomTopBar({
    Key? key,
    this.title,
    this.titleWidget,
    required this.icon,
    this.height = kToolbarHeight,
    this.actions,
    this.onTap,
    this.centerTitle = false,
  }) : super(
          key: key,
        );

  final String? title;
  final Widget? titleWidget;
  final Widget icon;
  final double height;
  final List<Widget>? actions;
  final VoidCallback? onTap;
  final bool centerTitle;

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: UIConstants().bgColor,
  //     height: height,
  //     margin: getMargin(top: MediaQuery.of(context).padding.top),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         icon,
  //         if (centerTitle)
  //           Expanded(child: Center(child: _titleWidget))
  //         else
  //           _titleWidget,
  //         actions != null
  //             ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
  //             : SizedBox.shrink(),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (centerTitle) {
      return _buildCenteredTitleBar(context);
    } else {
      return _buildDefault(context);
    }
  }

  Widget _buildCenteredTitleBar(BuildContext context) {
    return Container(
      color: UIConstants().bgColor,
      height: getVerticalSize(height),
      margin: getMargin(top: MediaQuery.of(context).padding.top),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: icon,
          ),
          Center(
            child: titleWidget ??
                AppbarTitle(
                  text: title ?? '',
                  margin: EdgeInsets.zero,
                ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions ?? [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefault(BuildContext context) {
    return Container(
      color: UIConstants().bgColor,
      height: getVerticalSize(height),
      margin: getMargin(top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Expanded(
            child: Container(
              margin: getMargin(left: 16),
              alignment: Alignment.centerLeft,
              child: titleWidget ?? AppbarTitle(text: title ?? ''),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions ?? [],
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: UIConstants().bgColor,
  //     height: height,
  //     margin: getMargin(top: MediaQuery.of(context).padding.top),
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child: icon,
  //         ),
  //         Center(
  //           child: titleWidget ??
  //               AppbarSubtitle(text: title ?? '', margin: EdgeInsets.zero),
  //         ),
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: actions ?? [],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Size get preferredSize => Size.fromHeight(height);

  // Widget get _titleWidget {
  //   return titleWidget ??
  //       AppbarTitle(
  //         text: title!,
  //         margin: getMargin(left: centerTitle ? 0 : 16),
  //       );
  // }
}
