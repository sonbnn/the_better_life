import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_water.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/utils/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        initWater();
        final user = await SharedPrefsService.getUserInfo();
        if (user.recommendedMilli != null && user.recommendedMilli != 0) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushNamed(context, RoutingNameConstants.DashBoard);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.pushNamed(context, RoutingNameConstants.BeforeStartScreen);
          });
        }
      },
    );
  }

  void initWater() {
    DateTime dateTime = DateTime.now();
    ConstantWater.dateNow = "${dateTime.day}/${dateTime.month}";
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
