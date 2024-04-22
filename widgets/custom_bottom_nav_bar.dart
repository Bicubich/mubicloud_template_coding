import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mubicloud/core/app_export.dart';
import 'package:mubicloud/core/constants/UIConstants.dart';
import 'package:mubicloud/presentation/mini_player_screen/mini_player_screen.dart';

import 'app_bar/custum_bottom_bar_controller.dart';

enum BottomBarEnum {
  Search,
  Library,
  Profile,
  Playlists,
  Playlist,
  Selections,
}

class BottomBarTab {
  static const int playlists = 1;
  static const int search = 2;
  static const int selections = 3;
  static const int profile = 4;
  static const int all = 5;
}

class BottomMenuModel {
  BottomMenuModel({
    this.imagePath,
    this.icon,
    this.selectedImagePath,
    this.title,
    this.children,
    required this.type,
  });

  final String? imagePath;
  final String? selectedImagePath;
  final IconData? icon;
  final String? title;
  final List<BottomMenuModel>? children;
  final BottomBarEnum type;
}

// ignore: must_be_immutable
class CustomBottomNavBar extends StatelessWidget {
  Function(BottomBarEnum)? onChanged;

  CustomBottomNavBar({
    Key? key,
    this.onChanged,
  }) : super(
          key: key,
        );

  final CustomBottomBarController controller =
      Get.put(CustomBottomBarController());

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      imagePath: ImageConstant.imglibraryIcon,
      title: "lbl_playlists".tr,
      type: BottomBarEnum.Playlists,
      selectedImagePath: ImageConstant.imglibraryIconSelected,
    ),
    BottomMenuModel(
        imagePath: ImageConstant.iconBottomBarTracks,
        title: "lbl_tracks".tr,
        type: BottomBarEnum.Search,
        selectedImagePath: ImageConstant.iconBottomBarTracks),
    BottomMenuModel(
      imagePath: ImageConstant.iconSelection,
      title: "lbl_selections".tr,
      type: BottomBarEnum.Selections,
      selectedImagePath: ImageConstant.iconSelection,
    ),
    BottomMenuModel(
        imagePath: ImageConstant.imgprofileIcon,
        title: "lbl_profile".tr,
        type: BottomBarEnum.Profile,
        selectedImagePath: ImageConstant.imgProfileIconSelected),
  ];

  @override
  Widget build(BuildContext context) {
    var menuList = bottomMenuList.toList();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      MiniPlayerScreen(),
      Container(
          height: getVerticalSize(80), // Your desired height
          decoration: BoxDecoration(
            color: appTheme.footerColor,
            //boxShadow: [
            //  BoxShadow(
            //    // color: UIConstants().textColor.withOpacity(0.03),
            //    color: appTheme.footerColor.withOpacity(0.03),
            //    spreadRadius: getHorizontalSize(0),
            //    blurRadius: getHorizontalSize(16),
            //    offset: Offset(0, -6),
            //  ),
            //],
          ),
          child: GetBuilder<CustomBottomBarController>(
              init: CustomBottomBarController(),
              builder: (controller) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = menuList[index];
                      return Material(
                          color: Colors.transparent,
                          child: InkWell(
                              enableFeedback: false,
                              splashColor:
                                  appTheme.footerColor.withOpacity(0.03),
                              onTap: () {
                                controller.updateIndex(index);
                              },
                              child: Container(
                                  height: double.infinity,
                                  width: MediaQuery.of(context).size.width /
                                      menuList.length,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        item.icon != null
                                            ? Icon(item.icon,
                                                color: controller
                                                            .selectedIndex ==
                                                        index
                                                    ? appTheme.deepPurpleA200
                                                    : UIConstants().textColor,
                                                size: 24)
                                            : CustomImageView(
                                                color: controller
                                                            .selectedIndex ==
                                                        index
                                                    ? appTheme.deepPurpleA200
                                                    : UIConstants().textColor,
                                                svgPath:
                                                    controller.selectedIndex ==
                                                            index
                                                        ? item.selectedImagePath
                                                        : item.imagePath,
                                                height: getVerticalSize(
                                                  24,
                                                ),
                                                width: getVerticalSize(
                                                  24,
                                                ),
                                              ),
                                        Padding(
                                          padding: getPadding(top: 7.h),
                                          child: Text(
                                            item.title ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: UIConstants()
                                                .textStyleMedium
                                                .copyWith(
                                                  color: controller
                                                              .selectedIndex ==
                                                          index
                                                      ? appTheme.deepPurpleA200
                                                      : UIConstants().textColor,
                                                  fontSize: 10.sp,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))));
                    },
                  )))
    ]);
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIConstants().textLightMode,
      padding: EdgeInsets.all(10.h.w),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
