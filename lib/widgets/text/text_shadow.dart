import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TextShadow extends StatelessWidget {

  final String text;
  final TextStyle? style;
  const TextShadow( {super.key, required this.text, this.style }) ;

  @override
  Widget build(BuildContext context) {
    return  ClipRect(
      child:  Stack(
        children: [
           Positioned(
            top: 2.0,
            left: 2.0,
            child:  Text(
              text,
              style: style?.copyWith(color: Colors.grey.withOpacity(0.5)),
            ),
          ),
           BackdropFilter(
            filter:  ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child:  Text(text, style: style),
          ),
        ],
      ),
    );
  }
}