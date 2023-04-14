import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class LetGoScreen extends StatefulWidget {
  const LetGoScreen({Key? key}) : super(key: key);

  @override
  State<LetGoScreen> createState() => _LetGoScreenState();
}

class _LetGoScreenState extends State<LetGoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).saveUserInfo();
      Provider.of<DrinkProvider>(context, listen: false).setCurrentDay();
      Provider.of<UserProvider>(context, listen: false).setNotification(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, providerUser, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TXT_AMOUNT_WATER_DAY'.tr(), style: textTheme.headline6),
              Text('${providerUser.user.recommendedMilli?.toStringAsFixed(0)} ml', style: textTheme.headline6),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonShadowOuter(
                  size: const Size(double.infinity, 56),
                  action: () {
                    Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstants.DashBoard, (route) => false);
                  },
                  child: Text(
                    'TXT_LET_GO'.tr(),
                    style: textTheme.button,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
