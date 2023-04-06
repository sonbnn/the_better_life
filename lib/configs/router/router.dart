import 'package:flutter/material.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/screens/home_screen.dart';
import 'package:the_better_life/features/screens/splash_screen.dart';

abstract class RoutesConstants {
  static final routes = <String, WidgetBuilder>{
    RoutingNameConstants.SplashScreen: (BuildContext context) => const SplashScreen(),
    RoutingNameConstants.HomeScreen: (BuildContext context) => const HomeScreen(),
  };
}
