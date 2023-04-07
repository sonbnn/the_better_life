import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_gender.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_sleep.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_wake_up.dart';
import 'package:the_better_life/features/screens/before_start/widget/select_weight.dart';
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
  List<Widget> screens = [const SelectGender(), const SelectWeight(), const SelectWakeUp(), const SelectSleep()];
  late DrinkProvider targetProvider;
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    targetProvider = Provider.of<DrinkProvider>(context, listen: false);
    theme =  Theme.of(context);
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
                      _buildTopItem(srcIcon: 'assets/icons/ic_gender.svg', data: providerUser.user.gender, index: 0),
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_scale.svg',
                        data: providerUser.user.weight != null ? '${providerUser.user.weight?.toStringAsFixed(0)}kg' : null,
                        index: 1,
                      ),
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_alarm-clock.svg',
                        data: providerUser.user.wakeUpTime,
                        index: 2,
                      ),
                      _buildTopItem(
                        srcIcon: 'assets/icons/ic_sleep.svg',
                        data: providerUser.user.bedTime,
                        index: 3,
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
                        onPressed: (){
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

  Widget _buildTopItem({required String srcIcon, required String? data, required int index}) {
    return Column(
      children: [
        ContainerShadowCommon(
          size: const Size(80, 40),
          padding: const EdgeInsets.all(10),
          color: index <= targetProvider.currentIndexPage ? theme.primaryColor : theme.backgroundColor,
          radius: 24,
          child: CommonImage(
            url: srcIcon,
            color: index <= targetProvider.currentIndexPage ?theme.backgroundColor :  theme.disabledColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(data ?? '_ _ _',style: theme.textTheme.headline6),
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

  void _nextPage({required UserProvider userProvider, required DrinkProvider drinkProvider}){
    switch(drinkProvider.currentIndexPage){
      case 0:
        if(userProvider.user.gender != null){
          drinkProvider.setCurrentIndexPage(drinkProvider.currentIndexPage + 1);
        }else{
          SnackBarBuilder.showSnackBar(content: 'Select your gender!', status: false);
        }
        break;
      case 1:
        if(userProvider.user.weight != null){
          drinkProvider.setCurrentIndexPage(drinkProvider.currentIndexPage + 1);
        }else{
          SnackBarBuilder.showSnackBar(content: 'Select your weight!', status: false);
        }
        break;
      case 2:
        if(userProvider.user.wakeUpTime != null){
          drinkProvider.setCurrentIndexPage(drinkProvider.currentIndexPage + 1);
        }else{
          SnackBarBuilder.showSnackBar(content: 'Select your wakeup time!', status: false);
        }
        break;
      case 3:
        if(userProvider.user.bedTime != null){
          userProvider.setWatterQuantity();
          Navigator.pushNamed(context, RoutingNameConstants.LetGoScreen);
        }else{
          SnackBarBuilder.showSnackBar(content: 'Select your sleep time!', status: false);
        }
        break;
    }
  }
}