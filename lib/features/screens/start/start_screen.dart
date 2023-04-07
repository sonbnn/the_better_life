import 'package:flutter/material.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Xin chao ban'),
          Text('toi giup ban uong nuoc'),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(24),
        child: ButtonShadowOuter(
          action: () {
            Navigator.pushNamed(context, RoutingNameConstants.BeforeStartScreen);
          },
          child: Text('Bat dau nao'),
        ),
      ),
    );
  }
}