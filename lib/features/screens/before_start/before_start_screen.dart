import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_gender_age.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_sleep.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_wake_up.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_weight_height.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class BeforeStartScreen extends StatefulWidget {
  const BeforeStartScreen({Key? key}) : super(key: key);

  @override
  State<BeforeStartScreen> createState() => _BeforeStartScreenState();
}

class _BeforeStartScreenState extends State<BeforeStartScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> screens = [
    const SelectGenderAge(),
    const SelectWeightHeight(),
    const SelectWakeUp(),
    const SelectSleep()
  ];
  late DrinkProvider drinkProvider;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    drinkProvider = Provider.of<DrinkProvider>(context, listen: false);
    theme = Theme.of(context);

    return Scaffold(
      body: Consumer2<DrinkProvider, UserProvider>(
        builder: (context, providerDrink, providerUser, child) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_gender.svg',
                        data: '${providerUser.user.gender} - ${providerUser.user.age?.toStringAsFixed(0)}',
                        index: 0,
                        isHide: providerUser.user.gender == null || providerUser.user.age == null,
                      ),
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_scale.svg',
                        data:
                            '${providerUser.user.weight?.toStringAsFixed(0)}kg - ${providerUser.user.height?.toStringAsFixed(0)}cm',
                        index: 1,
                        isHide: providerUser.user.weight == null || providerUser.user.height == null,
                      ),
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_alarm-clock.svg',
                        data: providerUser.user.wakeUpTime ?? '',
                        index: 2,
                        isHide: providerUser.user.weight == null,
                      ),
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_sleep.svg',
                        data: providerUser.user.bedTime ?? '',
                        index: 3,
                        isHide: providerUser.user.bedTime == null,

                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageStorage(
                    bucket: bucket,
                    child: screens[providerDrink.currentIndexPage],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton(
                        onPressed: () {
                          if (providerDrink.currentIndexPage == 0) {
                            Navigator.pop(context);
                            return;
                          } else {
                            providerDrink.setCurrentIndexPage(providerDrink.currentIndexPage - 1);
                          }
                        },
                        icons: Icons.arrow_back_ios_sharp,
                      ),
                      _buildButton(
                        onPressed: () {
                          _nextPage(userProvider: providerUser, drinkProvider: providerDrink);
                        },
                        icons: Icons.arrow_forward_ios_sharp,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopItem({required String srcIcon, required String data, required int index, required bool isHide}) {
    return Column(
      children: [
        ContainerShadowCommon(
          size: const Size(80, 40),
          padding: const EdgeInsets.all(10),
          color: index <= drinkProvider.currentIndexPage ? theme.primaryColor : theme.backgroundColor,
          radius: 24,
          child: CommonImage(
            url: srcIcon,
            color: index <= drinkProvider.currentIndexPage ? theme.backgroundColor : theme.disabledColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(isHide ? '___' : data, style: theme.textTheme.bodyText2),
      ],
    );
  }

  Widget _buildButton({required IconData icons, required Function onPressed}) {
    return ButtonShadowOuter(
      size: const Size(56, 56),
      action: () => onPressed(),
      child: Icon(icons, color: theme.primaryColor),
    );
  }

  void _nextPage({required UserProvider userProvider, required DrinkProvider drinkProvider}) {
    switch (drinkProvider.currentIndexPage) {
      case 0:
        if (userProvider.user.gender != null && userProvider.user.age != null) {
          drinkProvider.setCurrentIndexPage(drinkProvider.currentIndexPage + 1);
        } else {
          SnackBarBuilder.showSnackBar(content: 'Select your gender and age!', status: false);
        }
        break;
      case 1:
        if (userProvider.user.weight != null && userProvider.user.height != null) {
          drinkProvider.setCurrentIndexPage(drinkProvider.currentIndexPage + 1);
        } else {
          SnackBarBuilder.showSnackBar(content: 'Select your weight and height!', status: false);
        }
        break;
      case 2:
        if (userProvider.user.wakeUpTime != null) {
          drinkProvider.setCurrentIndexPage(drinkProvider.currentIndexPage + 1);
        } else {
          SnackBarBuilder.showSnackBar(content: 'Select your wakeup time!', status: false);
        }
        break;
      case 3:
        if (userProvider.user.bedTime != null) {
          userProvider.setWatterQuantity();
          Navigator.pushNamed(context, RoutingNameConstants.LetGoScreen);
        } else {
          SnackBarBuilder.showSnackBar(content: 'Select your sleep time!', status: false);
        }
        break;
    }
  }
}
