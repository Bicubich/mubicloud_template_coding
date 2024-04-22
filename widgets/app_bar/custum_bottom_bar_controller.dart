import 'package:flutter/material.dart';
import 'package:mubicloud/presentation/search_screen_page/controller/search_screen_controller.dart';
import 'tab_navigator_observer.dart';

import '../../core/app_export.dart';
import '../custom_bottom_nav_bar.dart';

class CustomBottomBarController extends GetxController {
  int selectedIndex = 0;

  SearchScreenController searchScreenController =
      Get.put(SearchScreenController());

  late final List<GlobalKey<NavigatorState>?> routeKeys;
  late final List<TabNavigatorObserver> observers;

  final List<String> routes = [
    AppRoutes.myPlaylistsAddPage,
    AppRoutes.searchScreenPage,
    AppRoutes.selectionsScreen,
    AppRoutes.myProfileOnePage,
  ];

  @override
  void onInit() {
    super.onInit();

    routeKeys = [
      Get.nestedKey(BottomBarTab.playlists),
      Get.nestedKey(BottomBarTab.search),
      Get.nestedKey(BottomBarTab.selections),
      Get.nestedKey(BottomBarTab.profile),
    ];

    observers = [
      TabNavigatorObserver(),
      TabNavigatorObserver(),
      TabNavigatorObserver(),
      TabNavigatorObserver(),
    ];
  }

  updateIndex(int index) async {
    selectedIndex = index;
    //if (index == 0) {
    //  resetRouteToRoot();
    //}
    searchScreenController.setSearching(false);
    update();
  }

  void goToTab(int id, {String? route, Function(int id, String route)? cb}) {
    _updateIndexByTab(id);

    Future.delayed(Duration(milliseconds: 10), () {
      if (_observer.currentRoute.value == route) return;
      if (cb == null) return;
      if (route == null) return;

      cb(id, route);
    });
  }

  TabNavigatorObserver get _observer {
    switch (selectedIndex) {
      case BottomBarTab.playlists:
        return observers[0];
      case BottomBarTab.search:
        return observers[1];
      case BottomBarTab.selections:
        return observers[2];
      case BottomBarTab.profile:
        return observers[3];
      default:
        return observers[0];
    }
  }

  void _updateIndexByTab(int index) {
    switch (index) {
      case BottomBarTab.playlists:
        updateIndex(0);
        break;
      case BottomBarTab.search:
        updateIndex(1);
        break;
      case BottomBarTab.selections:
        updateIndex(2);
        break;
      case BottomBarTab.profile:
        updateIndex(3);
        break;
      default:
        updateIndex(0);
        break;
    }
  }

  void resetRouteToRoot() {
    final navigatorKey = routeKeys[selectedIndex];
    if (navigatorKey != null) {
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
  }
}
