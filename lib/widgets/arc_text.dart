import 'dart:math' as math;

import 'package:flutter/material.dart';

class ArcText extends StatelessWidget {
  const ArcText({
    Key? key,
    required this.radius,
    this.angle = 0,
    required this.letter,
    required this.textStyle,
  }) : super(key: key);

  final double radius;
  final double angle;
  final String letter;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(
        textStyle: textStyle,
        radius: radius,
        angle: angle,
        letter: letter,
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    required this.radius,
    required this.angle,
    required this.letter,
    required this.textStyle,
  });
  final double radius;
  final double angle;
  final String letter;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // print(size.width / 2);
    // print("size.width / 2");
    // print(size.height / 2);
    canvas.drawCircle(
        Offset.zero, radius, Paint()..style = PaintingStyle.stroke);
    canvas.rotate(angle);
    canvas.translate(0, -radius);
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );
    _textPainter.paint(
        canvas, Offset(-_textPainter.width / 2, -_textPainter.height));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
