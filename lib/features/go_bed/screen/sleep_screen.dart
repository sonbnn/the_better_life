import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/go_bed/provider/go_bed_provider.dart';
import 'package:the_better_life/features/go_bed/widget/time_sleep_box.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class GoBedScreen extends StatefulWidget {
  const GoBedScreen({Key? key}) : super(key: key);

  @override
  State<GoBedScreen> createState() => _GoBedScreenState();
}

class _GoBedScreenState extends State<GoBedScreen> {
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    Provider.of<GoBedProvider>(context, listen: false).getListHistory();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: 'TXT_BEDTIME'.tr(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutingNameConstants.ChartSleepScreen);
            },
            icon: Icon(
              Icons.insert_chart_outlined,
              color: theme.primaryColor,
            ),
          )
        ],
      ),
      body: Consumer2<UserProvider, GoBedProvider>(builder: (context, userProvider, goBedProvider, child) {
        return Column(
          children: [
            TimeSleepBox(provider: userProvider),
            _sleepToday(provider: goBedProvider),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 80,
            )
          ],
        );
      }),
    );
  }

  Widget _sleepToday({required GoBedProvider provider}) {
    return ContainerShadowCommon(
      padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('TXT_TO_DAY'.tr(), style: theme.textTheme.headline5),
              ButtonShadowOuter(
                size: const Size(34,34),
                radius: 12,
                padding: const EdgeInsets.all(4),
                action: (){
                  provider.saveToChart();
                },
                child: CommonImage(
                  url: 'assets/icons/ic_save.svg',
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bed, size: 20),
                        const SizedBox(width: 4),
                        Text('TXT_BEDTIME'.tr(), style: theme.textTheme.bodyText2),
                      ],
                    ),
                    provider.pickerBedToday != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(Constants.formatHour).format(provider.pickerBedToday!),
                                style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor),
                              ),
                              Text(
                                DateFormat(Constants.formatDate).format(provider.pickerBedToday!),
                                style: theme.textTheme.caption,
                              ),
                            ],
                          )
                        : Text(
                            '___',
                            style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor),
                          ),
                    ButtonShadowOuter(
                      size: const Size(60, 30),
                      margin: const EdgeInsets.only(top: 8),
                      action: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (date) {
                            provider.setTimeBedToday(date);
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      radius: 12,
                      child: Text('TXT_EDIT'.tr(), style: theme.textTheme.button),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_alarms_sharp, size: 20),
                        const SizedBox(width: 4),
                        Text('TXT_WAKE_UP_TIME'.tr(), style: theme.textTheme.bodyText2),
                      ],
                    ),
                    provider.pickerWakeUpToday != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(Constants.formatHour).format(provider.pickerWakeUpToday!),
                                style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor),
                              ),
                              Text(
                                DateFormat(Constants.formatDate).format(provider.pickerWakeUpToday!),
                                style: theme.textTheme.caption,
                              ),
                            ],
                          )
                        : Text(
                            '___',
                            style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor),
                          ),
                    ButtonShadowOuter(
                      size: const Size(60, 30),
                      margin: const EdgeInsets.only(top: 8),
                      action: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (date) {
                            provider.setTimeWakeUpToday(date);
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      radius: 12,
                      child: Text('TXT_EDIT'.tr(), style: theme.textTheme.button),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
