import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/drink_water/screens/home_water/widget/box_main_home.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';
import 'package:the_better_life/widgets/text/text_shadow.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({Key? key}) : super(key: key);

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      late DrinkProvider drinkProvider = Provider.of<DrinkProvider>(context, listen: false);
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
      appBar: BaseAppBar(title: 'TXT_DRINK_WATER'.tr()),
      body: Consumer2<DrinkProvider, UserProvider>(
        builder: (context, providerDrink, providerUser, child) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BoxMainWater(
                  drinkProvider: providerDrink,
                  userProvider: providerUser,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ContainerShadowCommon(
                    size: Size(size.width - 48, double.infinity),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: EdgeInsets.only(bottom: 70 + MediaQuery.of(context).padding.bottom),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        TextShadow(
                          text: 'TXT_TO_DAY'.tr(),
                          style: theme.textTheme.headline6,
                        ),
                        Expanded(
                          child: providerDrink.listHistoryDay.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: providerDrink.listHistoryDay.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return _buildItem(
                                      amount: '${providerDrink.listHistoryDay[index].amount?.toStringAsFixed(0)}',
                                      time: providerDrink.listHistoryDay[index].time ?? '',
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    'TXT_NULL_WATER_TODAY'.tr(),
                                    style: theme.textTheme.bodyText2,
                                    textAlign: TextAlign.center,
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
              style: theme.textTheme.bodyText1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(time, style: theme.textTheme.bodyText1),
        ],
      ),
    );
  }
}
