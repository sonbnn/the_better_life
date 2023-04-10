import 'package:flutter/material.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/bmi_caculator/screen/result_bmi.dart';
import 'package:the_better_life/features/drink_water/screens/history_water_screen.dart';
import 'package:the_better_life/features/screens/before_start/before_start_screen.dart';
import 'package:the_better_life/features/screens/before_start/letgo_screen.dart';
import 'package:the_better_life/features/screens/dashboard/dashboard.dart';
import 'package:the_better_life/features/screens/home_screen.dart';
import 'package:the_better_life/features/screens/setting/choose_language.dart';
import 'package:the_better_life/features/screens/setting/edit_personal.dart';
import 'package:the_better_life/features/screens/setting/setting_screen.dart';
import 'package:the_better_life/features/screens/splash_screen.dart';
import 'package:the_better_life/features/screens/start/start_screen.dart';

abstract class RoutesConstants {
  static final routes = <String, WidgetBuilder>{
    RoutingNameConstants.SplashScreen: (BuildContext context) => const SplashScreen(),
    RoutingNameConstants.StartScreen: (BuildContext context) => const StartScreen(),
    RoutingNameConstants.BeforeStartScreen: (BuildContext context) => const BeforeStartScreen(),
    RoutingNameConstants.LetGoScreen: (BuildContext context) => const LetGoScreen(),
    RoutingNameConstants.DashBoard: (BuildContext context) => const DashBoard(),
    RoutingNameConstants.HomeScreen: (BuildContext context) => const HomeScreen(),
    RoutingNameConstants.SettingScreen: (BuildContext context) => const SettingScreen(),
    RoutingNameConstants.ChooseLanguageScreen: (BuildContext context) => const ChooseLanguageScreen(),
    RoutingNameConstants.HistoryScreen: (BuildContext context) => const HistoryWaterScreen(),
    RoutingNameConstants.BMIResultScreen: (BuildContext context) => const BMIResultScreen(),
    RoutingNameConstants.EditPersonalScreen: (BuildContext context) => const EditPersonalScreen(),

  };
}
