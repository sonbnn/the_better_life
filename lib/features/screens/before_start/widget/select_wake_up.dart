import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/features/go_bed/widget/time_sleep_box.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class SelectWakeUp extends StatefulWidget {
  const SelectWakeUp({Key? key}) : super(key: key);

  @override
  State<SelectWakeUp> createState() => _SelectWakeUpState();
}

class _SelectWakeUpState extends State<SelectWakeUp> {
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    theme = Theme.of(context);
    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return SizedBox(
          width: sizeWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('TXT_CHOOSE_YOUR_BEDTIME_SCHEDULE'.tr(), style: theme.textTheme.headline5),
              TimeSleepBox(provider: provider),
            ],
          ),
        );
      }),
    );
  }

}
