import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_bmi.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
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
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.saveUserInfo();
      Provider.of<DrinkProvider>(context, listen: false).setCurrentDay();
      userProvider.setNotification(DateTime.now());
      userProvider.getBMI();
      userProvider.initBMI();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.all(ConstantSize.spaceMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  '${'TXT_AMOUNT_WATER_DAY'.tr()} ${provider.user.recommendedMilli?.toStringAsFixed(0)}ml',
                  style: textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Text("TXT_AND".tr(), style: textTheme.headline6),
                Text(
                  '${'TXT_YOUR_BMI_IS'.tr()} ${'${provider.bmiResult[ConstantBMI.getIndex(provider.bmi)]['title']}'.tr().toLowerCase()}',
                  style: textTheme.headline6,
                ),
                const Spacer(),
                ButtonShadowOuter(
                  size: const Size(double.infinity, 56),
                  action: () {
                    Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstants.DashBoard, (route) => false);
                  },
                  child: Text('TXT_LET_GO'.tr(), style: textTheme.button),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
