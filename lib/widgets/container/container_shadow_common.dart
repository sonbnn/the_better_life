import 'package:flutter/material.dart';

class ContainerShadowCommon extends StatelessWidget {
  Size? size;
  Widget? child;
  double? radius;
  EdgeInsets? padding;
  EdgeInsets? margin;
  Color? color;
  Color? colorShadowTopLeft;

  ContainerShadowCommon({
    Key? key,
    this.size,
    required this.child,
    this.radius,
    this.padding,
    this.margin,
    this.color,
    this.colorShadowTopLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: padding,
      margin: margin,
      width: size?.width,
      height: size?.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 18),
        color: color ?? const Color(0xFFE3EDF7),
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: colorShadowTopLeft ?? const Color(0xFFFFFFFF),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: child,
    );
  }
}
