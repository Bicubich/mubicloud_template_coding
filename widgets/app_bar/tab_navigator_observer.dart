import 'package:flutter/widgets.dart';

import '../../../core/app_export.dart';

class TabNavigatorObserver extends NavigatorObserver {
  final RxString currentRoute = ''.obs;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    currentRoute.value = route.settings.name ?? '';
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      currentRoute.value = previousRoute.settings.name ?? '';
    }
  }
}
