import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

class AppDecoration {
  static BoxDecoration get fill => BoxDecoration(
        color: appTheme.gray90090,
      );
  static BoxDecoration get white => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fill1 => BoxDecoration(
        color: appTheme.purple300,
      );
  static BoxDecoration get fill3 => BoxDecoration(
        color: appTheme.indigo5087,
      );
  static BoxDecoration get outline => BoxDecoration(
        border: Border.all(
          color: UIConstants().textColor,
          width: 1,
          strokeAlign: strokeAlignCenter,
        ),
      );
  static BoxDecoration get black => BoxDecoration(
        color: UIConstants().textColor,
      );
  static BoxDecoration get fill2 => BoxDecoration(
        color: appTheme.gray100,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorderPlaylists = BorderRadius.circular(
    10.r,
  );

  static BorderRadius roundedBorder16 = BorderRadius.circular(
    16.r,
  );

  static BorderRadius circleBorder40 = BorderRadius.circular(
    40.r,
  );

  static BorderRadius roundedBorder24 = BorderRadius.circular(
    24.r,
  );

  static BorderRadius roundedBorder13 = BorderRadius.circular(
    13.r,
  );

  static BorderRadius roundedBorder2 = BorderRadius.circular(
    2.r,
  );

  static BorderRadius customBorderTL32 = BorderRadius.only(
    topLeft: Radius.circular(
      32.r,
    ),
    topRight: Radius.circular(
      32.r,
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
