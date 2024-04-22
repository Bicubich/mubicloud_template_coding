import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';

import 'package:mubicloud/core/network/flutter_chrome_tap.dart';
import 'package:mubicloud/widgets/custom_elevated_button.dart';
import 'package:mubicloud/widgets/custom_text_form_field.dart';

import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setSafeAreaColor();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          closeApp();
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: appTheme.bgLoginColor,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: getPadding(left: 60, top: 60, right: 60, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Image.asset(
                        width: 200.w,
                        PrefUtils().getThemeData() == "primary"
                            ? ImageConstant.imageLogoWithText2
                            : ImageConstant.imageLogoWithText1,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: Image.asset(
                            ImageConstant.imagePlaylistCollage,
                          ),
                        ),
                        Image.asset(
                          ImageConstant.imageAccount,
                          width: 40.w,
                          color: PrefUtils().getThemeData() == "primary"
                              ? Color(0xFF8079e3)
                              : Color(0xFF4d6280),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "lbl_log_in2".tr,
                          textAlign: TextAlign.left,
                          style: UIConstants().textStyleMedium.copyWith(
                              color: PrefUtils().getThemeData() == "primary"
                                  ? Color(0xFF91a8c1)
                                  : Color(0xFF4d6280),
                              letterSpacing: 1.2),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              filled: true,
                              fillColor: PrefUtils().getThemeData() == "primary"
                                  ? Color(0xFF6b62e9)
                                  : Color(0xFF0c2137),
                              enabledBorderColor:
                                  PrefUtils().getThemeData() == "primary"
                                      ? Color(0xFF6b62e9)
                                      : Color(0xFF0c2137),
                              controller: controller.loginController,
                              contentPadding:
                                  getPadding(left: 20, top: 20, bottom: 20),
                              textStyle: UIConstants().textStyleSmall.copyWith(
                                  color: PrefUtils().getThemeData() == "primary"
                                      ? Color(0xFFb2afee)
                                      : Color(0xFF4d6280)),
                              hintText: "lbl_login2".tr,
                              hintStyle: UIConstants().textStyleSmall.copyWith(
                                  color: PrefUtils().getThemeData() == "primary"
                                      ? Color(0xFFb2afee)
                                      : Color(0xFF4d6280)),
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Пожалуйста, введите логин.";
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                        Padding(
                          padding: getPadding(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => CustomTextFormField(
                                    filled: true,
                                    fillColor:
                                        PrefUtils().getThemeData() == "primary"
                                            ? Color(0xFF6b62e9)
                                            : Color(0xFF0c2137),
                                    enabledBorderColor:
                                        PrefUtils().getThemeData() == "primary"
                                            ? Color(0xFF6b62e9)
                                            : Color(0xFF0c213),
                                    controller: controller.passwordController,
                                    margin: getMargin(top: 5),
                                    contentPadding: getPadding(
                                        left: 20, top: 20, bottom: 20),
                                    textStyle: UIConstants()
                                        .textStyleSmall
                                        .copyWith(
                                            color: PrefUtils().getThemeData() ==
                                                    "primary"
                                                ? Color(0xFFb2afee)
                                                : Color(0xFF4d6280)),
                                    hintText: "lbl_enter_password".tr,
                                    hintStyle: UIConstants()
                                        .textStyleSmall
                                        .copyWith(
                                            color: PrefUtils().getThemeData() ==
                                                    "primary"
                                                ? Color(0xFFb2afee)
                                                : Color(0xFF4d6280)),
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    suffix: InkWell(
                                      enableFeedback: false,
                                      onTap: () {
                                        controller.isShowPassword.value =
                                            !controller.isShowPassword.value;
                                      },
                                      child: Container(
                                        margin: getMargin(
                                            left: 12,
                                            top: 14,
                                            right: 12,
                                            bottom: 14),
                                        child: CustomImageView(
                                          svgPath:
                                              !controller.isShowPassword.value
                                                  ? ImageConstant.imgEye
                                                  : ImageConstant.imgEyeClose,
                                          color: PrefUtils().getThemeData() ==
                                                  "primary"
                                              ? Color(0xFF8982ed)
                                              : Color(0xFF213448),
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                    suffixConstraints: BoxConstraints(
                                      maxHeight: getVerticalSize(56),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Пожалуйста, введите пароль.";
                                      }
                                      return null;
                                    },
                                    obscureText:
                                        controller.isShowPassword.value),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              onTapTxtForgotpassword();
                            },
                            child: Padding(
                              padding: getPadding(top: 10),
                              child: Text(
                                "msg_forgot_password".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: UIConstants()
                                    .textStyleSmall
                                    .copyWith(color: appTheme.gray40087),
                              ),
                            ),
                          ),
                        ),
                        CustomElevatedButton(
                            text: "lbl_log_in".tr,
                            margin: getMargin(top: 35),
                            buttonStyle:
                                ButtonThemeHelper.fillDeeppurpleA200.copyWith(
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(
                                  double.maxFinite,
                                  getVerticalSize(60),
                                ),
                              ),
                            ),
                            buttonTextStyle: UIConstants()
                                .textStyleMediumBold
                                .copyWith(color: UIConstants().textDarkMode),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                onTapLoginone();
                              }
                            }),
                        Padding(
                          padding: getPadding(top: 35, bottom: 15),
                          child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "msg_don_t_have_an_account2".tr,
                                    style: UIConstants()
                                        .textStyleSmall
                                        .copyWith(color: appTheme.gray40087),
                                  ),
                                  TextSpan(
                                    text: "     ",
                                    style: UIConstants()
                                        .textStyleSmall
                                        .copyWith(color: appTheme.gray40087),
                                  ),
                                  TextSpan(
                                    text: "lbl_get_access".tr,
                                    style: UIConstants()
                                        .textStyleSmallBold
                                        .copyWith(
                                            color: appTheme.gray40087,
                                            decoration:
                                                TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          onTapTxtDonthaveanaccount(requestUrl),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapTxtForgotpassword() {
    Get.toNamed(
      AppRoutes.forgotPasswordScreen,
    );
  }

  onTapLoginone() async {
    if (await controller.handleLogin()) {
      PrefUtils.setIsSignIn(true);
      Get.toNamed(
        AppRoutes.homeScreenContainerScreen,
      );
    }
  }

  onTapTxtDonthaveanaccount(String url) {
    FlutterChromeTab().openUrl(context, url);
  }
}
