import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:flutter/material.dart';

class ButtonThemeHelper {
  static ButtonStyle get fillDeeppurpleA200 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepPurpleA200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
        ),
        shadowColor:
            PrefUtils().getThemeData() == "primary" ? Colors.transparent : null,
      );
  static ButtonStyle get fillGray100 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
        ),
        shadowColor:
            PrefUtils().getThemeData() == "primary" ? Colors.transparent : null,
      );
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              24.r,
            ),
            topRight: Radius.circular(
              24.r,
            ),
            bottomLeft: Radius.circular(
              0.r,
            ),
            bottomRight: Radius.circular(
              0.r,
            ),
          ),
        ),
        shadowColor:
            PrefUtils().getThemeData() == "primary" ? Colors.transparent : null,
      );
  static ButtonStyle get outlineDeeppurpleA200 => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: appTheme.deepPurpleA200,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.r,
          ),
        ),
        shadowColor:
            PrefUtils().getThemeData() == "primary" ? Colors.transparent : null,
      );
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
        shadowColor: PrefUtils().getThemeData() == "primary"
            ? MaterialStateProperty.all<Color>(Colors.transparent)
            : null,
      );
}
