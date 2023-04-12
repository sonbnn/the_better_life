import 'package:d_chart/d_chart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/features/go_bed/provider/go_bed_provider.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class ChartSleepScreen extends StatefulWidget {
  const ChartSleepScreen({Key? key}) : super(key: key);

  @override
  State<ChartSleepScreen> createState() => _ChartSleepScreenState();
}

class _ChartSleepScreenState extends State<ChartSleepScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(title: 'TXT_SLEEP_CHART'.tr()),
      body: Consumer<GoBedProvider>(builder: (context, provider, child) {
        return SafeArea(
          child: ContainerShadowCommon(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.all(ConstantSize.spaceMargin),
            child: Column(
              children: [
                Text(
                  'TXT_SLEEP_HISTORY30'.tr(),
                  style: theme.textTheme.bodyText1,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: ConstantSize.screenHeight * 0.7,
                  child: DChartBar(
                    data: [
                      {
                        'id': 'Bar',
                        'data': provider.dataSleep.map((e) {
                          return {
                            'domain': e.time,
                            'measure': e.percent,
                          };
                        }).toList(),
                      },
                    ],
                    domainLabelPaddingToAxisLine: 10,
                    axisLineTick: 1,
                    axisLinePointTick: 1,
                    axisLinePointWidth: 10,
                    axisLineColor: theme.primaryColor,
                    measureLabelPaddingToAxisLine: 10,
                    barColor: (barData, index, id) => theme.primaryColor,
                    yAxisTitle: "TXT_DATE".tr(),
                    xAxisTitle: "TXT_TOTAL_HOUR".tr(),
                    verticalDirection: false,
                    showBarValue: true,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
