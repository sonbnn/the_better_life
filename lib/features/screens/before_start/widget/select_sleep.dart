import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class SelectSleep extends StatefulWidget {
  const SelectSleep({Key? key}) : super(key: key);

  @override
  State<SelectSleep> createState() => _SelectSleepState();
}

class _SelectSleepState extends State<SelectSleep> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _showDialogPickTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return SizedBox(
          width: sizeWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${'TXT_YOU_CHOOSE_TO_SLEEP_AT'.tr()} ${provider.user.wakeUpTime}'),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ButtonShadowOuter(
                  size: const Size(double.infinity, 56),
                  action: _showDialogPickTime,
                  child: Text('TXT_RESELECT'.tr(), style: textTheme.button,),
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
      initialTime: const TimeOfDay(hour: 23, minute: 30),
      helpText: 'Select time sleep',
    );
    if (newTime == null) return;
    Provider.of<UserProvider>(context, listen: false).setTimeSleep(newTime);
  }
}
