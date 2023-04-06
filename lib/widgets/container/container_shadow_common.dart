import 'package:flutter/material.dart';

class ContainerShadowCommon extends StatelessWidget {

  Size? size;
  Widget? child;
  double? radius;
  EdgeInsets? padding;
  ContainerShadowCommon({
    Key? key,
    this.size,
    this.child,
    this.radius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: size?.width ?? 56,
      height: size?.height ?? 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 18),
        color: Color(0xFFE3EDF7),
        // color: Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
          BoxShadow(
            color: Color(0xFFFFFFFF),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(-2, -2),
          ),
        ],
      ),
      child: child ?? Icon(
        Icons.abc_outlined,
        color: Colors.black,
      ),
    );
  }
}
