import 'package:flutter/material.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';


class ButtonShadowOuter extends StatefulWidget {
  Function action;
  Widget child;
  ButtonShadowOuter({
    Key? key,
    required this.action,
    required this.child,
  }) : super(key: key);

  @override
  State<ButtonShadowOuter> createState() => _ButtonShadowOuterState();
}

class _ButtonShadowOuterState extends State<ButtonShadowOuter> {
  bool _condition = true;

  @override
  Widget build(BuildContext context) {
    return ContainerShadowCommon(
      size: const Size(double.infinity, 56),
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18))
        ),
        color: Colors.transparent,
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Color(0xFF212330).withOpacity(.1)),
          borderRadius: BorderRadius.circular(18),
          onTap: checkCondition,
          child: widget.child
        ),
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
