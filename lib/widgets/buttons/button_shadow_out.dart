import 'package:flutter/material.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class ButtonShadowOuter extends StatefulWidget {
  Function action;
  Widget child;
  Size? size;
  double? radius;
  EdgeInsets? padding;
  EdgeInsets? margin;
  Color? color;

  ButtonShadowOuter({
    Key? key,
    required this.action,
    required this.child,
    this.size,
    this.radius,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  @override
  State<ButtonShadowOuter> createState() => _ButtonShadowOuterState();
}

class _ButtonShadowOuterState extends State<ButtonShadowOuter> {
  bool _condition = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(const Color(0xFF212330).withOpacity(.1)),
      borderRadius: BorderRadius.circular(18),
      onTap: checkCondition,
      child: ContainerShadowCommon(
        size: widget.size ?? const Size(double.infinity, 56),
        padding: widget.padding,
        margin: widget.margin,
        color: widget.color,
        radius: widget.radius ?? 24,
        child: widget.child,
      ),
    );
  }

  void checkCondition() async {
    if (_condition) {
      setState(() => _condition = false);
      await widget.action();
      setState(() => _condition = true);
    }
  }
}
