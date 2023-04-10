import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class SelectGenderAge extends StatefulWidget {
  const SelectGenderAge({Key? key}) : super(key: key);

  @override
  State<SelectGenderAge> createState() => _SelectGenderAgeState();
}

class _SelectGenderAgeState extends State<SelectGenderAge> {
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
              Text('TXT_CHOOSE_YOUR_GENDER_AGE'.tr(), style: theme.textTheme.headline5),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildItem(gender: 'TXT_MALE'.tr(), urlIcon: 'assets/icons/ic_boy.svg', provider: provider),
                  _buildItem(gender: 'TXT_FEMALE'.tr(), urlIcon: 'assets/icons/ic_girl.svg', provider: provider),
                ],
              ),
              const SizedBox(height: 24),
              ContainerShadowCommon(
                size: Size((size.width / 2) - 30, (size.width / 2) - 30),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Your age', style: theme.textTheme.headline5),
                    const SizedBox(height: 12),
                    Text('${provider.user.age?.toStringAsFixed(0) ?? 20}', style: theme.textTheme.headline1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonShadowOuter(
                          size: const Size(56, 56),
                          action: (){
                            provider.plusAge(-1);
                          },
                          child: Text('-', style: theme.textTheme.headline1),
                        ),
                        ButtonShadowOuter(
                          size: const Size(56, 56),
                          action: () {
                            provider.plusAge(1);
                          },
                          child: Text('+', style: theme.textTheme.headline1),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem({required String gender, required String urlIcon, required UserProvider provider}) {
    return ButtonShadowOuter(
      size: Size((size.width / 2) - 30, (size.width / 2) - 30),
      padding: const EdgeInsets.all(30),
      color: gender == provider.user.gender ? theme.primaryColor : theme.backgroundColor,
      action: () => provider.setGender(gender),
      child: Column(
        children: [
          Expanded(child: CommonImage(url: urlIcon)),
          const SizedBox(height: 8),
          Text(
            gender,
            style: theme.textTheme.headline3?.copyWith(
              color: gender == provider.user.gender ? Colors.white : theme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
