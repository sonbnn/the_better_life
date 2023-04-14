import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/configs/constants/constant_water.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/helper/notification.dart';
import 'package:the_better_life/helper/sound_controller.dart';
import 'package:the_better_life/utils/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        initSize();
        // _initGoogleMobileAds();
        notificationService.initNotification();
        SoundController.initSound();
        final user = await SharedPrefsService.getUserInfo();
        if (user.recommendedMilli != null && user.recommendedMilli != 0) {
          initWater();
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstants.DashBoard, (route) => false);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstants.BeforeStartScreen, (route) => false);
          });
        }
      },
    );
  }

  void initWater() {
    DateTime dateTime = DateTime.now();
    ConstantWater.dateNow = DateFormat(Constants.formatDateMonth).format(dateTime);
  }

  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   return MobileAds.instance.initialize();
  // }

  void initSize() {
    Size size = MediaQuery.of(context).size;
    ConstantSize.screenWidth = size.width;
    ConstantSize.screenHeight = size.height;
    ConstantSize.isSmallScreen = ConstantSize.screenWidth <= 380; // if is a small phone return true
    ConstantSize.isMobile = ConstantSize.screenWidth < 600; // if is a ipad return false
    ConstantSize.isLargeScreen = size.width > 600 ? true : false;
    if (ConstantSize.screenWidth < 380) {
      ConstantSize.spaceMargin = 10;
    } else {
      ConstantSize.spaceMargin = 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash screen'),
      ),
    );
  }
}
