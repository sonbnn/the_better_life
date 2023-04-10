import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
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
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(title: 'TXT_BEDTIME'.tr()),
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return Column(
          children: [
            TimeSleepBox(provider: provider),
            _sleepToday(),
          ],
        );
      }),
    );
  }

  Widget _sleepToday() {
    return ContainerShadowCommon(
      padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin),
      child: Column(
        children: [
          Text('TXT_TO_DAY'.tr(), style: theme.textTheme.headline5),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bed, size: 20),
                        const SizedBox(width: 4),
                        Text('TXT_BEDTIME'.tr(), style: theme.textTheme.bodyText1),
                      ],
                    ),
                    Text('____', style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor)),
                    ButtonShadowOuter(
                      size: const Size(60, 30),
                      margin: const EdgeInsets.only(top: 8),
                      action: () {},
                      radius: 12,
                      child: Text('TXT_EDIT'.tr(), style: theme.textTheme.button),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bed, size: 20),
                        const SizedBox(width: 4),
                        Text('TXT_WAKE_UP_TIME'.tr(), style: theme.textTheme.bodyText1),
                      ],
                    ),
                    Text('____', style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor)),
                    ButtonShadowOuter(
                      size: const Size(60, 30),
                      margin: const EdgeInsets.only(top: 8),
                      action: () {},
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
