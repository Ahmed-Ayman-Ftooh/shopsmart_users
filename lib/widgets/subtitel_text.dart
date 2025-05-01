import 'package:flutter/material.dart';

class SubtitelTextWidget extends StatelessWidget {
  const SubtitelTextWidget({
    super.key,
    required this.lable,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.fontStyle = FontStyle.normal,
    this.decoration = TextDecoration.none,
  });
  final String lable;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final FontStyle fontStyle;
  final TextDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}
