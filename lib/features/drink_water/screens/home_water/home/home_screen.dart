import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/model/user.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/drink_water/screens/home_water/home/widget/box_main_home.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';
import 'package:the_better_life/widgets/text/text_shadow.dart';

class WatterScreen extends StatefulWidget {
  const WatterScreen({Key? key}) : super(key: key);

  @override
  State<WatterScreen> createState() => _WatterScreenState();
}

class _WatterScreenState extends State<WatterScreen> with TickerProviderStateMixin {
  late DrinkProvider drinkProvider;
  User user = User();
  double oldValue = 0;

  @override
  void initState() {
    super.initState();
    drinkProvider = Provider.of<DrinkProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<UserProvider>(context, listen: false).getUserInfoData();
      drinkProvider.initProvider();
      drinkProvider.checkDay();
    });
  }

  late Size size;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer2<DrinkProvider, UserProvider>(
        builder: (context, providerDrink, providerUser, child) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'TXT_DRINK_WATER'.tr(),
                    style: theme.textTheme.headline3,
                  ),
                ),
                BoxMainHome(drinkProvider: drinkProvider, userProvider: providerUser,),
                const SizedBox(height: 24),
                Expanded(
                  child: ContainerShadowCommon(
                    size: Size(size.width- 48, double.infinity),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: EdgeInsets.only(bottom: 80 + MediaQuery.of(context).padding.bottom),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        TextShadow(
                          text: '${'TXT_TO_DAY'.tr()} ${drinkProvider.currentDay}',
                          style: theme.textTheme.headline4,
                        ),
                        Expanded(
                          child: drinkProvider.listHistoryDay.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: drinkProvider.listHistoryDay.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return _buildItem(
                                amount: '${drinkProvider.listHistoryDay[index].amount?.toStringAsFixed(0)}',
                                time: drinkProvider.listHistoryDay[index].time ?? '',
                              );
                            },
                          )
                              : Center(
                            child: Text(
                              'TXT_NULL_WATER_TODAY'.tr(),
                              style: theme.textTheme.headline6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem({required String amount, required String time}) {
    return SizedBox(
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.water_drop_outlined, color: theme.dividerColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${amount}ml',
              style: theme.textTheme.headline6,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            time,
            style: theme.textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
