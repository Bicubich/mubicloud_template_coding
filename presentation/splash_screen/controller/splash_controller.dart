import 'dart:async';

import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/presentation/splash_screen/models/splash_model.dart';

/// A controller class for the SplashScreen.
///
/// This class manages the state of the SplashScreen, including the
/// current splashModelObj
class SplashController extends GetxController {
  Rx<SplashModel> splashModelObj = SplashModel().obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      print("themedata is ======== ${PrefUtils().getThemeData()}");
      _getIsFirst();
    });
  }

  _getIsFirst() async {
    bool isSignIn = !await PrefUtils.getIsSignIn();
    bool isIntro = await PrefUtils.getIsIntro();
    Timer(const Duration(seconds: 3), () {
      print("is intro ====== $isIntro");
      print("isSignIn ====== $isSignIn");
      if (isIntro) {
        Get.toNamed(AppRoutes.onboardingFourScreen);
      } else if (isSignIn) {
        Get.toNamed(AppRoutes.loginScreen);
      } else {
        Get.toNamed(AppRoutes.homeScreenContainerScreen);
      }
    });
  }
}
