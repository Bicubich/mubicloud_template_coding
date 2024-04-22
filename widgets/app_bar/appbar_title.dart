import 'package:flutter/material.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

import '../../core/utils/string_utils.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    Key? key,
    required this.text,
    this.titleize = false,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;
  bool titleize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(titleize ? toTitleCase(text) : text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: UIConstants().textStyleLargeBold.copyWith(
                  color: UIConstants().textColor,
                )),
      ),
    );
  }
}
