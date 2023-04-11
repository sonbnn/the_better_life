import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/utils/snackbar_builder.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class TimeSleepBox extends StatefulWidget {
  final UserProvider provider;

  const TimeSleepBox({Key? key, required this.provider}) : super(key: key);

  @override
  State<TimeSleepBox> createState() => _TimeSleepBoxState();
}

class _TimeSleepBoxState extends State<TimeSleepBox> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return ContainerShadowCommon(
      padding: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 12),
      margin: EdgeInsets.all(ConstantSize.spaceMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TXT_SCHEDULE'.tr(), style: theme.textTheme.headline5),
          const Divider(),
          Row(
            children: [
              _item(
                time: '${widget.provider.user.bedTime}',
                title: 'TXT_BEDTIME'.tr(),
                iconData: Icons.bed_rounded,
                actionEdit: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 6, minute: 30),
                    helpText: 'TXT_EDIT_BED_TIME'.tr(),
                  );
                  if (newTime == null) return;
                  if ('${newTime.hour}:${newTime.minute}' == widget.provider.user.wakeUpTime) {
                    SnackBarBuilder.showSnackBar(content: 'TXT_SET_TIME_ERR'.tr(), status: false);
                    return;
                  }
                  widget.provider.setTimeSleep(newTime);
                  widget.provider.saveUserInfo();
                },
              ),
              _item(
                time: '${widget.provider.user.wakeUpTime}',
                title: 'TXT_WAKE_UP_TIME'.tr(),
                actionEdit: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 23, minute: 30),
                    helpText: 'TXT_EDIT_WAKEUP_TIME'.tr(),
                  );
                  if (newTime == null) return;
                  if ('${newTime.hour}:${newTime.minute}' == widget.provider.user.bedTime) {
                    SnackBarBuilder.showSnackBar(content: 'TXT_SET_TIME_ERR'.tr(), status: false);
                    return;
                  }
                  widget.provider.setTimeWakeUp(newTime);
                  widget.provider.saveUserInfo();
                },
                iconData: Icons.access_alarms_sharp,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String time,
    required String title,
    required Function actionEdit,
    required IconData iconData,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData, size: 20),
              const SizedBox(width: 4),
              Text(title, style: theme.textTheme.bodyText2),
            ],
          ),
          Text(time, style: theme.textTheme.headline5?.copyWith(color: theme.primaryColor)),
          ButtonShadowOuter(
            size: const Size(60, 30),
            margin: const EdgeInsets.only(top: 8),
            action: actionEdit,
            radius: 12,
            child: Text('TXT_EDIT'.tr(), style: theme.textTheme.button),
          )
        ],
      ),
    );
  }
}
