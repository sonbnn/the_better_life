import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/screens/setting/widget/item_setting.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(title: 'TXT_SETTING'.tr()),
      body: SafeArea(
        child: Column(
          children: [
            ItemSetting(
              icName: 'ic_personal',
              title: 'TXT_PERSONAL_INFORMATION'.tr(),
              onTap: () {
                Navigator.pushNamed(context, RoutingNameConstants.EditPersonalScreen);
              },
            ),
            ItemSetting(
              icName: 'ic_language',
              title: 'TXT_CHANGE_LANGUAGE'.tr(),
              onTap: () {
                Navigator.pushNamed(context, RoutingNameConstants.ChooseLanguageScreen);
              },
            ),
            ItemSetting(
              icName: 'ic_setting',
              title: 'TXT_APP_VERSION'.tr(),
              onTap: () {},
              itemRight: Text(Constants.appVersion, style: theme.textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }
}
