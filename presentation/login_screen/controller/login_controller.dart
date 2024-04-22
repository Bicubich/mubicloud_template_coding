import 'package:flutter/material.dart';

/// A controller class for the LoginScreen.
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/presentation/login_screen/models/login_model.dart';

import '../../../core/utils/app_metrica.dart';
import '../../../data/apiClient/mubicloud_api.dart';

///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {
  TextEditingController loginController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;

  Rx<bool> isShowPassword = true.obs;

  Future<bool> handleLogin() async {
    final login = loginController.text;
    final password = passwordController.text;

    try {
      await MubicloudApi().login(login, password);
    } catch (e) {
      if (AppConfig().isDevelopment) {
        Logger.log('Login failed: ${e.toString()}');
      }
    }

    await setAppMetricaProfileId();

    return MubicloudApi().isLoggedIn;
  }
}
