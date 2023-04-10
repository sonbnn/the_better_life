import 'package:flutter/material.dart';

class ContainerShadowCommon extends StatelessWidget {
  final Size? size;
  final Widget? child;
  final double? radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final Color? colorShadowTopLeft;

  const ContainerShadowCommon({
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
        borderRadius: BorderRadius.circular(radius ?? 12),
        color: color ?? const Color(0xFFE3EDF7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: colorShadowTopLeft ?? const Color(0xFFFFFFFF).withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: child,
    );
  }
}
