import 'package:flutter/material.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';


class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigatePushAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  BuildContext getContext() {
    return navigatorKey.currentState!.overlay!.context;
  }

  void showToast(data) {
    SnackBarBuilder.showSnackBar(content: data, status: false);
  }
}
