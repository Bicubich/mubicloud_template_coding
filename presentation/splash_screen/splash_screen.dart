import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:mubicloud/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    setSafeAreaColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.bgColor,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              PrefUtils().getThemeData() == "primary"
                  ? ImageConstant.imagePlaylistInsideBackgroundLight
                  : ImageConstant.imagePlaylistInsideBackgroundDark,
            ),
            fit: BoxFit.cover, // Растягиваем изображение на весь экран
          ),
        ),
        child: Padding(
          padding: getPadding(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Lottie.asset(
                'assets/images/lottie/mubicloud.json',
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
              ),
              SvgPicture.asset(
                'assets/images/logo-text.svg',
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
