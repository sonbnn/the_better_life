import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:the_better_life/widgets/common/custom_box_decoration.dart';
import 'package:the_better_life/widgets/common/custom_boxshadow.dart';

class ContainerShadowInner extends StatelessWidget {
  Size? size;
  double radiusParent;
  double radiusChild;
  Color? backgroundColor;
  Widget? child;
  double widthBorder;
  bool error;
  ContainerShadowInner({
    Key? key,
    this.size,
    this.radiusParent = 24,
    this.radiusChild = 23,
    this.backgroundColor,
    this.child,
    this.widthBorder = 3,
    this.error = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widthBorder),
      width: size?.width ?? double.infinity,
      height: size?.height ?? 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusParent),
        color: error ? null : (backgroundColor ?? const Color(0xFFE3EDF7)),
        // color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(.25),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: size?.height ?? 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusChild),
          border: error ? Border.all(
            color: Colors.red,
            width: widthBorder
          ) : null,
          color: backgroundColor ?? const Color(0xFFE3EDF7),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFFFFFFF),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(-3, -3),
              inset: true
            ),
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(3, 3),
              inset: true
            ),
          ]
        ),
        child: child,
      ),
    );
  }
}
