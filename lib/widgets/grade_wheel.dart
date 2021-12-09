import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gpa_cgpa_calculator/widgets/arc_text.dart';

class GradeWheel extends StatefulWidget {
  const GradeWheel({Key? key}) : super(key: key);

  @override
  State<GradeWheel> createState() => _GradeWheelState();
}

class _GradeWheelState extends State<GradeWheel> {
  double _angle = 0;
  void _rotateWheel(double rotation) {
    setState(() {
      _showWheelFlag = true;
      _angle = rotation;
    });
  }

  double pressYPosition = 0;
  double dragYPosition = 0;
  double dragYDelta = 0;
  double prevDragYDelta = 0;
  bool _showWheelFlag = false;

  void _showWheel() {
    setState(() {
      _showWheelFlag = true;
    });
  }

  void _hideWheel() {
    setState(() {
      _showWheelFlag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onVerticalDragEnd: (_) => _hideWheel(),
      //onLongPressStart: (_) => _showWheel(),
      // onLongPressEnd: (_) => _hideWheel(),
      onVerticalDragUpdate: (details) {
        dragYPosition = details.globalPosition.dy;
        // print(dragYPosition);
        // print(dragYDelta);
        dragYDelta = (((dragYPosition - pressYPosition) / 700) * 2 * math.pi);

        // print(dragYDelta);
        _rotateWheel(dragYDelta);
        prevDragYDelta = dragYDelta;
      },
      // onLongPressDown: (details) {
      //   print(details.globalPosition);
      //   pressYPosition = details.globalPosition.dy;
      // },
      onTapDown: (details) {
        pressYPosition = details.globalPosition.dy;
        _showWheel();
      },
      onTapUp: (_) {
        _hideWheel();
      },
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: Colors.blue,
          ),
          _showWheelFlag
              ? Transform.rotate(
                  angle: 2 * _angle,
                  child: Center(
                    child: Container(
                      color: Colors.amber,
                      width: 300,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          ArcText(
                            angle: (1 * (2 * math.pi / 3)),
                            radius: 100,
                            letter: "A",
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          ArcText(
                            angle: (2 * (2 * math.pi / 3)),
                            radius: 100,
                            letter: "B",
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                          ArcText(
                            angle: (3 * (2 * math.pi / 3)),
                            radius: 100,
                            letter: "C",
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
