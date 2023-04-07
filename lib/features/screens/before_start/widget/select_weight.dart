import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/user/user_provider.dart';
import 'package:the_better_life/widgets/input/weight/weight_slider.dart';

class SelectWeight extends StatefulWidget {
  const SelectWeight({Key? key}) : super(key: key);

  @override
  State<SelectWeight> createState() => _SelectWeightState();
}

class _SelectWeightState extends State<SelectWeight> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TXT_CHOOSE_YOUR_WEIGHT'.tr(), style: theme.textTheme.headline3),
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
              ),
            ),
          ],
        );
      },
    );
  }
}
