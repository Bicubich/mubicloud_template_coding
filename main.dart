import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/core/databases/hive_database.dart';
import 'package:mubicloud/core/services/app_metrica_navigation_observer.dart';
import 'package:mubicloud/data/apiClient/mubicloud_api.dart';
import 'package:mubicloud/core/repositories/profile_repository.dart';
import 'package:rollbar_flutter/rollbar.dart' show RollbarFlutter;
import 'package:rollbar_flutter/rollbar.dart' as rollbar;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/app_export.dart';
import 'core/utils/app_metrica.dart';
import 'core/utils/global_audio_handler.dart';

Future<void> main() async {
  await loadComponents();
  await appMetricaInstall();
  await setAppMetricaProfileId();
  await accessCheck();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light, // For iOS: (dark icons)
      statusBarIconBrightness: PrefUtils().getThemeData() == "primary"
          ? Brightness.dark
          : Brightness.light, // For Android: (dark icons)
    ),
  );

  String env = AppConfig().currentEnvironment;
  var rollbarConfig = rollbar.Config(
    accessToken: AppConfig()['RollbarSecret'],
    environment: env,
    package: 'mubicloud',
    codeVersion: await _appVersion(),
    handleUncaughtErrors: true,
    includePlatformLogs: true,
    // handleUncaughtErrors: AppConfig().isProduction,
    // includePlatformLogs: AppConfig().isProduction,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) async {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    await RollbarFlutter.run(rollbarConfig, () {
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   const platform = MethodChannel('com.mubicloud.app/splash');
    //   platform.invokeMethod('flutterReady');
    // });

    return ScreenUtilInit(
        designSize: Size(428, 926),
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                bottomSheetTheme:
                    BottomSheetThemeData(backgroundColor: appTheme.white700),
                dialogBackgroundColor: UIConstants().bgColor,
                progressIndicatorTheme:
                    ProgressIndicatorThemeData(color: appTheme.deepPurpleA200),
                canvasColor: appTheme.deepPurpleA200,
                colorScheme: theme.colorScheme,
                useMaterial3: true,
                visualDensity: VisualDensity.standard,
              ),
              navigatorObservers: [AppMetricaNavigationObserver()],
              translations: AppLocalization(),
              locale: Get.deviceLocale,
              fallbackLocale: Locale('ru', 'RU'),
              supportedLocales: [Locale('ru', 'RU')],
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              title: 'Mubicloud',
              initialBinding: InitialBindings(),
              initialRoute: AppRoutes.initialRoute,
              getPages: AppRoutes.pages,
            ));
  }
}

Future<void> appMetricaInstall() async {
  await AppMetrica.activate(AppConfig()['AppMetricaSecret'], await _appBuild(),
      await _appVersion(), true);
}

Future<String> _appVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<int> _appBuild() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return int.parse(packageInfo.buildNumber);
}

Future<void> accessCheck() async {
  await Permission.ignoreBatteryOptimizations.request();
  await Permission.location.request();
}

Future<void> loadComponents() async {
  await AppConfig().init();
  await HiveDatabase().init();
  await PrefUtils().init();
  await MubicloudApi().init();
  if (MubicloudApi().isLoggedIn) {
    var resp = await MubicloudApi().profile();
    var _profileRepository = ProfileRepository();
    if (resp?.id == null) {
      await _profileRepository.deleteProfile();
      Get.offAllNamed(AppRoutes.loginScreen);
    } else {
      await _profileRepository.importProfile(resp);
    }
    await setAppMetricaProfileId();
  }
  await GlobalAudioHandler.init();
}
