import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';
import 'package:the_better_life/widgets/input/weight/weight_slider.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  late ThemeData theme;
  late Size size;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'TXT_BMI_CALCULATOR'.tr(),
                      style: theme.textTheme.headline3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildItemGender(
                        gender: 'TXT_MALE'.tr(),
                        urlIcon: 'assets/icons/ic_boy.svg',
                        provider: userProvider,
                      ),
                      _buildItemGender(
                        gender: 'TXT_FEMALE'.tr(),
                        urlIcon: 'assets/icons/ic_girl.svg',
                        provider: userProvider,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  WeightSlider(
                    weight: (userProvider.user.weight != null ? userProvider.user.weight ?? 0 : 50).toInt(),
                    minWeight: 20,
                    maxWeight: 200,
                    onChange: (val) => userProvider.setWeight(val.toDouble()),
                    unit: 'kg',
                    title: 'TXT_YOUR_WEIGHT'.tr(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildItemOther(
                        actionPlus: () => userProvider.plusAge(1),
                        actionMinus: () => userProvider.plusAge(-1),
                        title: 'Your age',
                        value: '${userProvider.user.age?.toStringAsFixed(0)}',
                      ),
                      _buildItemOther(
                        actionPlus: () => userProvider.plusHeight(1),
                        actionMinus: () => userProvider.plusHeight(-1),
                        title: 'Your height',
                        value: '${userProvider.user.height?.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ButtonShadowOuter(
                    action: () {
                      userProvider.getBMI();
                      Navigator.pushNamed(context, RoutingNameConstants.BMIResultScreen);
                    },
                    child: Text(
                      'Calculate BMI',
                      style: theme.textTheme.button,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemGender({required String gender, required String urlIcon, required UserProvider provider}) {
    return ButtonShadowOuter(
      size: Size((size.width / 2) - 30, (size.width / 2) - 30),
      padding: const EdgeInsets.all(12),
      color: gender == provider.user.gender ? theme.primaryColor : theme.backgroundColor,
      action: () => provider.setGender(gender),
      child: Column(
        children: [
          Expanded(child: CommonImage(url: urlIcon)),
          const SizedBox(height: 8),
          Text(
            gender,
            style: theme.textTheme.headline5?.copyWith(
              color: gender == provider.user.gender ? Colors.white : theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemOther({
    required String title,
    required String value,
    required Function actionPlus,
    required Function actionMinus,
  }) {
    return ContainerShadowCommon(
      size: Size((size.width / 2) - 30, (size.width / 2) - 30),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.headline5),
          const SizedBox(height: 12),
          Text(value, style: theme.textTheme.headline1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonShadowOuter(
                size: const Size(56, 56),
                action: actionMinus,
                child: Text('-', style: theme.textTheme.headline1),
              ),
              ButtonShadowOuter(
                size: const Size(56, 56),
                action: actionPlus,
                child: Text('+', style: theme.textTheme.headline1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
