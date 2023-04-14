import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/configs/constants/constants.dart';
import 'package:the_better_life/configs/router/routing_name.dart';
import 'package:the_better_life/features/screens/setting/widget/item_setting.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

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
            ContainerShadowCommon(
              size: const Size(double.infinity, 66),
              radius: 12,
              margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  CommonImage(url: 'assets/icons/ic_setting.svg', color: theme.dividerColor, width: 36),
                  const SizedBox(width: 12),
                  Expanded(child: Text('TXT_APP_VERSION'.tr(), style: theme.textTheme.bodyText1)),
                  Text(Constants.appVersion, style: theme.textTheme.bodyText1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
