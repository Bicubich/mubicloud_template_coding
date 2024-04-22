import 'package:flutter/material.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

import '../core/app_export.dart';

class TextThemeHelper {
  static get titleMediumPrimary_1 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get titleLargeAirbnbCerealWBd =>
      theme.textTheme.titleLarge!.airbnbCerealWBd;

  static get titleMediumSemiBold => theme.textTheme.titleMedium!.copyWith(
        fontSize: getFontSize(
          17,
        ),
        fontWeight: FontWeight.w600,
      );

  static get bodyMediumRed400 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.red400,
      );

  static get bodyLargeGray700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray700,
      );

  static get bodyLargeGray600 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray600,
        fontSize: getFontSize(
          16,
        ),
      );

  static get titleMediumDeeppurpleA200 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deepPurpleA200,
      );

  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: getFontSize(
          17,
        ),
        fontWeight: FontWeight.w600,
      );
  static get text16width400Black => theme.textTheme.titleMedium!.copyWith(
        color: UIConstants().textColor,
        fontSize: getFontSize(
          16,
        ),
        fontFamily: "SF Pro Display",
        fontWeight: FontWeight.w400,
      );

  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get titleLarge20 => theme.textTheme.titleLarge!.copyWith(
        fontSize: getFontSize(
          20,
        ),
      );

  static get bodyLargeGray600_1 => theme.textTheme.bodyLarge!.copyWith(
        // color: appTheme.gray600,
        color: appTheme.blueGray300,
      );

  static get bodyLarge => theme.textTheme.bodyLarge!.copyWith(
        fontSize: getFontSize(
          16,
        ),
      );

  static get bodyLargeOpenSansGray600 =>
      theme.textTheme.bodyLarge!.openSans.copyWith(
        color: appTheme.gray600,
        fontSize: getFontSize(
          16,
        ),
      );

  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: UIConstants().textColor,
      );

  static get titleMediumDeeppurpleA20017 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deepPurpleA200,
        fontSize: getFontSize(
          17,
        ),
      );
  static get titleMediumwhitrA20017 => theme.textTheme.titleMedium!.copyWith(
      color: UIConstants().textLightMode,
      fontSize: getFontSize(
        17,
      ),
      fontWeight: FontWeight.w400);
  static get titleMediumBlackA20017 => theme.textTheme.titleMedium!.copyWith(
      color: Color(0xFF425c80),
      fontSize: getFontSize(
        17,
      ),
      fontWeight: FontWeight.w400);

  static get titleLargeOpenSans => theme.textTheme.titleLarge!.openSans;

  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyMediumDeeppurpleA200 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.deepPurpleA200,
        fontSize: getFontSize(
          13,
        ),
      );

  static get bodyMedium13 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: getFontSize(
          13,
        ),
      );
}

extension on TextStyle {
  TextStyle get airbnbCerealWBd {
    return copyWith(
      fontFamily: 'AirbnbCereal_W_Bd',
    );
  }

  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }
}
