import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/input/weight/weight_slider.dart';

class SelectWeightHeight extends StatefulWidget {
  const SelectWeightHeight({Key? key}) : super(key: key);

  @override
  State<SelectWeightHeight> createState() => _SelectWeightHeightState();
}

class _SelectWeightHeightState extends State<SelectWeightHeight> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TXT_CHOOSE_YOUR_WEIGHT_HEIGHT'.tr(), style: theme.textTheme.headline5),
                const SizedBox(width: 8),
                const CommonImage(url: 'assets/icons/ic_move_left_right.svg')
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: WeightSlider(
                weight: (provider.user.weight != null ? provider.user.weight ?? 0 : 50).toInt(),
                minWeight: 20,
                maxWeight: 200,
                onChange: (val) => provider.setWeight(val.toDouble()),
                unit: 'kg',
                title: 'TXT_YOUR_WEIGHT'.tr(),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: WeightSlider(
                weight: (provider.user.height != null ? provider.user.height ?? 0 : 150).toInt(),
                minWeight: 100,
                maxWeight: 250,
                onChange: (val) => provider.setHeight(val.toDouble()),
                unit: 'cm',
                title: 'TXT_YOUR_HEIGHT'.tr(),
              ),
            ),
          ],
        );
      },
    );
  }
}
