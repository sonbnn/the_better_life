import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class SelectWakeUp extends StatefulWidget {
  const SelectWakeUp({Key? key}) : super(key: key);

  @override
  State<SelectWakeUp> createState() => _SelectWakeUpState();
}

class _SelectWakeUpState extends State<SelectWakeUp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showDialogPickTime();
    });
  }

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

              Text(
                'TXT_CHOOSE_YOUR_TIME_WAKE_UP'.tr(),
                style: theme.textTheme.headline3,
              ),
              const SizedBox(height: 24),
              Text(
                '${'TXT_YOU_CHOOSE_TO_WAKE_UP_AT'.tr()} ${provider.user.wakeUpTime}',
                style: theme.textTheme.headline3,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonShadowOuter(
                  size: const Size(double.infinity, 56),
                  action: _showDialogPickTime,
                  child: Text('TXT_RESELECT'.tr(), style: theme.textTheme.button,),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showDialogPickTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 6, minute: 30),
      helpText: 'Select time wakeup',

    );
    if (newTime == null) return;
    Provider.of<UserProvider>(context, listen: false).setTimeWakeUp(newTime);
  }
}
