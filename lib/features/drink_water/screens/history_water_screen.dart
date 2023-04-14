import 'dart:math';

import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class HistoryWaterScreen extends StatefulWidget {
  const HistoryWaterScreen({Key? key}) : super(key: key);

  @override
  State<HistoryWaterScreen> createState() => _HistoryWaterScreenState();
}

class _HistoryWaterScreenState extends State<HistoryWaterScreen> {
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(title: 'TXT_HISTORY_WATER'.tr()),
      body: Consumer<DrinkProvider>(builder: (context, provider, child) {
        String tipTxt = provider.tipDrink[Random().nextInt(provider.tipDrink.length)];

        return SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  ContainerShadowCommon(
                    margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 12),
                    size: Size(ConstantSize.screenWidth - ConstantSize.spaceMargin * 2, 100),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ButtonShadowOuter(
                              margin: const EdgeInsets.all(12),
                              action: provider.randomTip,
                              size: const Size(66, 66),
                              padding: const EdgeInsets.all(8),
                              child: const CommonImage(url: 'assets/images/img_water.png'),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Icon(Icons.change_circle, color: theme.primaryColor),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            provider.tipTxt,
                            style: textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                ],
              ),
              provider.listHistoryMonth.isNotEmpty
                  ? Expanded(
                      child: ContainerShadowCommon(
                        margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text('TXT_HISTORY_WATER30'.tr(), style: textTheme.bodyText1),
                            const SizedBox(height: 12),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: provider.listHistoryMonth.length,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(24),
                                itemBuilder: (context, index) {
                                  return _buildItem(
                                    result: '${provider.listHistoryMonth[index].result}',
                                    time: provider.listHistoryMonth[index].date ?? '',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sim_card_alert_outlined,
                            color: theme.disabledColor,
                            size: 100,
                          ),
                          Text(
                            'TXT_NULL_DATA_WATER_HISTORY'.tr(),
                            textAlign: TextAlign.center,
                            style: textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildItem({required String result, required String time}) {
    return Row(
      children: [
        const Icon(Icons.water_drop_outlined),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            '${result}ml',
            style: textTheme.bodyText1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          time,
          style: textTheme.bodyText1,
        ),
      ],
    );
  }
}
