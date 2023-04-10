import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';

class ItemSetting extends StatelessWidget {
  final String icName;
  final String title;
  final Function onTap;
  final Widget? itemRight;
  const ItemSetting({Key? key, required this.icName, required this.title, required this.onTap, this.itemRight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ButtonShadowOuter(
      action: onTap,
      size: const Size(double.infinity, 66),
      radius: 12,
      margin: EdgeInsets.symmetric(horizontal: ConstantSize.spaceMargin, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          CommonImage(url: 'assets/icons/$icName.svg', color: theme.dividerColor, width: 36),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: theme.textTheme.bodyText1)),
          itemRight ?? const Icon(Icons.navigate_next)
        ],
      ),
    );
  }
}
