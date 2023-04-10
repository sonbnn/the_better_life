import 'package:flutter/material.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class ButtonShadowOuter extends StatefulWidget {
  final Function action;
  final Widget child;
  final Size? size;
  final double? radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;

  const ButtonShadowOuter({
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
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      borderRadius: BorderRadius.circular(18),
      onTap: checkCondition,
      child: ContainerShadowCommon(
        size: widget.size ?? const Size(double.infinity, 56),
        padding: widget.padding,
        margin: widget.margin,
        color: widget.color,
        radius: widget.radius ?? 12,
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
