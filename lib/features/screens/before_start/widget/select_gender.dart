import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({Key? key}) : super(key: key);

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  late Size size;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TXT_CHOOSE_YOUR_GENDER'.tr(), style: theme.textTheme.headline3),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildItem(gender: 'TXT_MALE'.tr(), urlIcon: 'assets/icons/ic_boy.svg', provider: provider),
                  _buildItem(gender: 'TXT_FEMALE'.tr(), urlIcon: 'assets/icons/ic_girl.svg', provider: provider),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem({required String gender, required String urlIcon, required UserProvider provider}) {
    return Column(
      children: [
        ButtonShadowOuter(
          size: Size(size.width / 3, size.width / 3),
          padding: const EdgeInsets.all(30),
          color: gender == provider.user.gender ? theme.primaryColor : theme.backgroundColor,
          action: () => provider.setGender(gender),
          child: CommonImage(url: urlIcon),
        ),
        const SizedBox(height: 8),
        Text(
          gender,
          style: theme.textTheme.headline3?.copyWith(
            color: gender == provider.user.gender ? Color(0xFF2A4067) : theme.disabledColor,
          ),
        ),
      ],
    );
  }
}
