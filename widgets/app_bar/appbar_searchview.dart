import 'package:flutter/material.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

import 'package:mubicloud/widgets/custom_search_view.dart';

// ignore: must_be_immutable
class AppbarSearchview extends StatelessWidget {
  AppbarSearchview(
      {Key? key, this.hintText, this.controller, this.margin, this.onSave})
      : super(
          key: key,
        );

  String? hintText;
  final FormFieldSetter<String>? onSave;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        onSave: onSave,
        width: getHorizontalSize(
          322,
        ),
        controller: controller,
        hintText: "lbl_search".tr,
        hintStyle: theme.textTheme.bodyLarge!,
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "TT Commons",
            fontSize: getFontSize(17),
            color: UIConstants().textColor),
        prefix: Container(
          margin: getMargin(
            left: 16,
            top: 12,
            right: 12,
            bottom: 12,
          ),
          child: CustomImageView(
            svgPath: PrefUtils().getThemeData() == "primary"
                ? ImageConstant.imgSearchBlack900
                : ImageConstant.imgSearchWhite,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: getVerticalSize(
            48,
          ),
        ),
        filled: true,
        fillColor: appTheme.gray100,
        contentPadding: getPadding(
          top: 13,
          right: 52,
          bottom: 13,
        ),
      ),
    );
  }
}
