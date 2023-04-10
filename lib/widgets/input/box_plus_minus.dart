import 'package:flutter/material.dart';
import 'package:the_better_life/configs/constants/constant_size.dart';
import 'package:the_better_life/widgets/buttons/button_shadow_out.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class BoxPlusMinus extends StatefulWidget {
  final String title;
  final String value;
  final Function actionPlus;
  final Function actionMinus;
  const BoxPlusMinus({
    Key? key,
    required this.title,
    required this.value,
    required this.actionPlus,
    required this.actionMinus,
  }) : super(key: key);

  @override
  State<BoxPlusMinus> createState() => _BoxPlusMinusState();
}

class _BoxPlusMinusState extends State<BoxPlusMinus> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    double sizeBox = (size.width / 2) - ConstantSize.spaceMargin - 6;
    return ContainerShadowCommon(
      size: Size(sizeBox, sizeBox - 28),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, style: theme.textTheme.bodyText1),
          const SizedBox(height: 12),
          Text(widget.value, style: theme.textTheme.headline3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonShadowOuter(
                size: const Size(50, 50),
                action: widget.actionMinus,
                child: Text('-', style: theme.textTheme.headline1),
              ),
              ButtonShadowOuter(
                size: const Size(50, 50),
                action: widget.actionPlus,
                child: Text('+', style: theme.textTheme.headline1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
