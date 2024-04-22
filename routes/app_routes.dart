import 'package:mubicloud/presentation/my_playlists_add_page/binding/my_playlists_add_binding.dart';
import 'package:mubicloud/presentation/my_playlists_add_page/my_playlists_add_page.dart';
import 'package:mubicloud/presentation/onboarding_four_screen/onboarding_four_screen.dart';
import 'package:mubicloud/presentation/onboarding_four_screen/binding/onboarding_four_binding.dart';
import 'package:mubicloud/presentation/search_screen_page/search_screen_page.dart';
import 'package:mubicloud/presentation/selection_screen/binding/selection_binding.dart';
import 'package:mubicloud/presentation/selection_screen/selection_screen.dart';
import 'package:mubicloud/presentation/splash_screen/splash_screen.dart';
import 'package:mubicloud/presentation/splash_screen/binding/splash_binding.dart';
import 'package:mubicloud/presentation/login_screen/login_screen.dart';
import 'package:mubicloud/presentation/login_screen/binding/login_binding.dart';
import 'package:mubicloud/presentation/login_fill_screen/login_fill_screen.dart';
import 'package:mubicloud/presentation/login_fill_screen/binding/login_fill_binding.dart';
// import 'package:mubicloud/presentation/sign_up_screen/sign_up_screen.dart';
// import 'package:mubicloud/presentation/sign_up_screen/binding/sign_up_binding.dart';
import 'package:mubicloud/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:mubicloud/presentation/forgot_password_screen/binding/forgot_password_binding.dart';
// import 'package:mubicloud/presentation/otp_verification_screen/otp_verification_screen.dart';
// import 'package:mubicloud/presentation/otp_verification_screen/binding/otp_verification_binding.dart';
import 'package:mubicloud/presentation/reset_password_one_screen/reset_password_one_screen.dart';
import 'package:mubicloud/presentation/reset_password_one_screen/binding/reset_password_one_binding.dart';
import 'package:mubicloud/presentation/reset_password_screen/reset_password_screen.dart';
import 'package:mubicloud/presentation/reset_password_screen/binding/reset_password_binding.dart';
import 'package:mubicloud/presentation/home_screen_container_screen/home_screen_container_screen.dart';
import 'package:mubicloud/presentation/home_screen_container_screen/binding/home_screen_container_binding.dart';
import 'package:mubicloud/presentation/tracks_screen/tracks_screen.dart';
import 'package:mubicloud/presentation/tracks_screen/binding/tracks_binding.dart';
import 'package:mubicloud/presentation/playlist_screen/playlist_screen.dart';
import 'package:mubicloud/presentation/playlist_screen/binding/playlist_binding.dart';
import 'package:mubicloud/presentation/play_screen/play_screen.dart';
import 'package:mubicloud/presentation/play_screen/binding/play_binding.dart';
import 'package:mubicloud/presentation/more_otion_popup_screen/more_otion_popup_screen.dart';
import 'package:mubicloud/presentation/more_otion_popup_screen/binding/more_otion_popup_binding.dart';
import 'package:mubicloud/presentation/notifications_screen/notifications_screen.dart';
import 'package:mubicloud/presentation/notifications_screen/binding/notifications_binding.dart';
import 'package:mubicloud/presentation/add_playlist_screen/add_playlist_screen.dart';
import 'package:mubicloud/presentation/add_playlist_screen/binding/add_playlist_binding.dart';
import 'package:mubicloud/presentation/my_profile_screen/my_profile_screen.dart';
import 'package:mubicloud/presentation/my_profile_screen/binding/my_profile_binding.dart';
import 'package:mubicloud/presentation/edit_profile_screen/edit_profile_screen.dart';
import 'package:mubicloud/presentation/edit_profile_screen/binding/edit_profile_binding.dart';
import 'package:mubicloud/presentation/settings_screen/settings_screen.dart';
import 'package:mubicloud/presentation/settings_screen/binding/settings_binding.dart';
import 'package:mubicloud/presentation/about_us_screen/about_us_screen.dart';
import 'package:mubicloud/presentation/about_us_screen/binding/about_us_binding.dart';
import 'package:mubicloud/presentation/about_us_one_screen/about_us_one_screen.dart';
import 'package:mubicloud/presentation/about_us_one_screen/binding/about_us_one_binding.dart';
import 'package:mubicloud/presentation/rate_us_screen/rate_us_screen.dart';
import 'package:mubicloud/presentation/rate_us_screen/binding/rate_us_binding.dart';
import 'package:mubicloud/presentation/feedback_screen/feedback_screen.dart';
import 'package:mubicloud/presentation/feedback_screen/binding/feedback_binding.dart';
import 'package:mubicloud/presentation/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:mubicloud/presentation/privacy_policy_screen/binding/privacy_policy_binding.dart';
import 'package:mubicloud/presentation/log_out_popup_screen/log_out_popup_screen.dart';
import 'package:mubicloud/presentation/log_out_popup_screen/binding/log_out_popup_binding.dart';
// import 'package:mubicloud/presentation/app_navigation_screen/app_navigation_screen.dart';
// import 'package:mubicloud/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:get/get.dart';

import '../presentation/search_screen_page/binding/search_screen_binding.dart';

class AppRoutes {
  static const String onboardingFourScreen = '/onboarding_four_screen';

  static const String splashScreen = '/splash_screen';

  static const String onboardingFiveScreen = '/onboarding_five_screen';

  static const String onboardingSixScreen = '/onboarding_six_screen';

  static const String loginScreen = '/login_screen';

  static const String loginErrorScreen = '/login_error_screen';

  static const String loginFillScreen = '/login_fill_screen';

  // static const String signUpScreen = '/sign_up_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  // static const String otpVerificationScreen = '/otp_verification_screen';

  static const String resetPasswordOneScreen = '/reset_password_one_screen';

  static const String resetPasswordScreen = '/reset_password_screen';

  static const String homeScreenPage = '/home_screen_page';

  static const String homeScreenContainerScreen =
      '/home_screen_container_screen';

  static const String recentlyPlayedScreen = '/recently_played_screen';

  static const String recommendedForYouScreen = '/recommended_for_you_screen';

  static const String playlistScreen = '/playlist_screen';

  static const String playScreen = '/play_screen';

  static const String artistSongScreen = '/artist_song_screen';

  static const String moreOtionPopupScreen = '/more_otion_popup_screen';
  static const String playlistOptionPopupScreen =
      '/playlist_options_popup_screen';

  static const String shareScreen = '/share_screen';

  static const String notificationsEmptyScreen = '/notifications_empty_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String searchScreenPage = '/search_screen_page';

  static const String myLibaryAddPage = '/my_libary_add_page';

  static const String myPlaylistsAddPage = '/my_playlists_add_page';

  static const String selectionsScreen = '/selections_screen';

  static const String myLibaryScreen = '/my_libary_screen';

  static const String addPlaylistScreen = '/add_playlist_screen';

  static const String selectionsPage = '/selections_page';

  static const String myProfileOnePage = '/my_profile_one_page';

  static const String myProfileScreen = '/my_profile_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String settingsScreen = '/settings_screen';

  static const String aboutUsScreen = '/about_us_screen';

  static const String aboutUsOneScreen = '/about_us_one_screen';

  static const String rateUsScreen = '/rate_us_screen';

  static const String feedbackScreen = '/feedback_screen';

  static const String privacyPolicyScreen = '/privacy_policy_screen';

  static const String logOutPopupScreen = '/log_out_popup_screen';

  // static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static const String selectionScreen = '/selection_screen';

  static List<GetPage> pages = [
    GetPage(
      name: onboardingFourScreen,
      page: () => OnboardingFourScreen(),
      bindings: [
        OnboardingFourBinding(),
      ],
    ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: loginFillScreen,
      page: () => LoginFillScreen(),
      bindings: [
        LoginFillBinding(),
      ],
    ),
    // GetPage(
    //   name: signUpScreen,
    //   page: () => SignUpScreen(),
    //   bindings: [
    //     SignUpBinding(),
    //   ],
    // ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
    ),
    // GetPage(
    //   name: otpVerificationScreen,
    //   page: () => OtpVerificationScreen(),
    //   bindings: [
    //     OtpVerificationBinding(),
    //   ],
    // ),
    GetPage(
      name: resetPasswordOneScreen,
      page: () => ResetPasswordOneScreen(),
      bindings: [
        ResetPasswordOneBinding(),
      ],
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      bindings: [
        ResetPasswordBinding(),
      ],
    ),
    GetPage(
      name: homeScreenContainerScreen,
      page: () => HomeScreenContainerScreen(),
      bindings: [
        HomeScreenContainerBinding(),
      ],
    ),
    GetPage(
      name: recentlyPlayedScreen,
      page: () => TracksScreen(),
      bindings: [
        TracksBinding(),
      ],
    ),
    GetPage(
      name: myPlaylistsAddPage,
      page: () => MyPlaylistsAddPage(),
      bindings: [
        MyPlaylistsAddBinding(),
      ],
    ),
    GetPage(
      name: playlistScreen,
      page: () => PlaylistScreen(),
      bindings: [
        PlaylistBinding(),
      ],
    ),
    GetPage(
      name: addPlaylistScreen,
      page: () => AddPlaylistScreen(),
      bindings: [
        AddPlaylistBinding(),
      ],
    ),
    GetPage(
      name: playScreen,
      page: () => PlayScreen(),
      bindings: [
        PlayBinding(),
      ],
    ),
    GetPage(
      name: moreOtionPopupScreen,
      page: () => MoreOtionPopupScreen(),
      bindings: [
        MoreOtionPopupBinding(),
      ],
    ),
    GetPage(
      name: notificationsScreen,
      page: () => NotificationsScreen(),
      bindings: [
        NotificationsBinding(),
      ],
    ),
    GetPage(
      name: searchScreenPage,
      page: () => SearchScreenPage(),
      bindings: [
        SearchScreenBinding(),
      ],
    ),
    GetPage(
      name: myProfileScreen,
      page: () => MyProfileScreen(),
      bindings: [
        MyProfileBinding(),
      ],
    ),
    GetPage(
      name: editProfileScreen,
      page: () => EditProfileScreen(),
      bindings: [
        EditProfileBinding(),
      ],
    ),
    GetPage(
      name: settingsScreen,
      page: () => SettingsScreen(),
      bindings: [
        SettingsBinding(),
      ],
    ),
    GetPage(
      name: aboutUsScreen,
      page: () => AboutUsScreen(),
      bindings: [
        AboutUsBinding(),
      ],
    ),
    GetPage(
      name: aboutUsOneScreen,
      page: () => AboutUsOneScreen(),
      bindings: [
        AboutUsOneBinding(),
      ],
    ),
    GetPage(
      name: rateUsScreen,
      page: () => RateUsScreen(),
      bindings: [
        RateUsBinding(),
      ],
    ),
    GetPage(
      name: feedbackScreen,
      page: () => FeedbackScreen(),
      bindings: [
        FeedbackBinding(),
      ],
    ),
    GetPage(
      name: privacyPolicyScreen,
      page: () => PrivacyPolicyScreen(),
      bindings: [
        PrivacyPolicyBinding(),
      ],
    ),
    GetPage(
      name: logOutPopupScreen,
      page: () => LogOutPopupScreen(),
      bindings: [
        LogOutPopupBinding(),
      ],
    ),
    // GetPage(
    //   name: appNavigationScreen,
    //   page: () => AppNavigationScreen(),
    //   bindings: [
    //     AppNavigationBinding(),
    //   ],
    // ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: selectionScreen,
      page: () => SelectionScreen(),
      bindings: [
        SelectionBinding(),
      ],
    ),
  ];
}
