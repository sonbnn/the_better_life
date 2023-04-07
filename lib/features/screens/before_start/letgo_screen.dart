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
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Consumer2<UserProvider, DrinkProvider>(
        builder: (context, providerUser, providerDrink, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('so luong nuoc ban phai uong hang ngay la'),
              Text('${providerUser.user.recommendedMilli?.toStringAsFixed(0)} MILLILITRE'),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonShadowOuter(
                  size: const Size(double.infinity, 56),
                  action: () {
                    providerUser.saveUserInfo();
                    providerDrink.setCurrentDay();
                    Navigator.pushNamed(context, RoutingNameConstants.DashBoard);
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
