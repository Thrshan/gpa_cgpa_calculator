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
      _angle = rotation;
    });
  }

  double pressYPosition = 0;
  double dragYPosition = 0;
  double dragYDelta = 0;
  double prevDragYDelta = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onVerticalDragEnd: (_) => print('verticalDragCancel'),
      onVerticalDragUpdate: (details) {
        dragYPosition = details.globalPosition.dy;
        // print(dragYPosition);
        print(dragYDelta);
        dragYDelta = (((dragYPosition - pressYPosition) / 700) * 2 * math.pi);

        // print(dragYDelta);
        _rotateWheel(dragYDelta);
        prevDragYDelta = dragYDelta;
      },
      onLongPressDown: (details) {
        // print(details.globalPosition);
        pressYPosition = details.globalPosition.dy;
      },
      onLongPress: () {
        print("kk2");
        print("kk");
      },
      onTapUp: (hh) {
        print('object');
      },
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: Colors.blue,
          ),
          Transform.rotate(
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
          ),
        ],
      ),
    );
  }
}
