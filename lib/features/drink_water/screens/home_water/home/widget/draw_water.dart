import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:the_better_life/features/drink_water/screens/home_water/home/widget/wave.dart';

const double _twoPi = math.pi * 2.0;
const double _epsilon = .001;
const double _sweep = _twoPi - _epsilon;

class LiquidCircularProgressIndicator extends ProgressIndicator {
  final Widget? center;
  final Axis direction;

  LiquidCircularProgressIndicator({
    Key? key,
    double value = 0.5,
    Color? backgroundColor,
    Animation<Color>? valueColor,
    this.center,
    this.direction = Axis.vertical,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        ) {}

  Color _getBackgroundColor(BuildContext context) => backgroundColor ?? Theme.of(context).backgroundColor;

  Color _getValueColor(BuildContext context) => valueColor?.value ?? Theme.of(context).accentColor;

  @override
  State<StatefulWidget> createState() => _LiquidCircularProgressIndicatorState();
}

class _LiquidCircularProgressIndicatorState extends State<LiquidCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CircleClipper(),
      child: CustomPaint(
        painter: _CirclePainter(
          color: widget._getBackgroundColor(context),
        ),
        child: Stack(
          children: [
            Wave(
              value: widget.value,
              color: widget._getValueColor(context),
              direction: widget.direction,
            ),
            if (widget.center != null) Center(child: widget.center),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;

  _CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawArc(Offset.zero & size, 0, _sweep, false, paint);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) => color != oldDelegate.color;
}

class _CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addArc(Offset.zero & size, 0, _sweep);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
