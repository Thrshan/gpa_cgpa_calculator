import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gpa_cgpa_calculator/widgets/arc_text.dart';

class GradeWheel extends StatefulWidget {
  final double angle;

  const GradeWheel({required this.angle, Key? key}) : super(key: key);

  @override
  State<GradeWheel> createState() => _GradeWheelState();
}

int noOfGrades = 5;

class _GradeWheelState extends State<GradeWheel> {
  List<Map<String, Object>> grades = [
    {"letter": "A", "angle": (1 * (2 * math.pi / noOfGrades))},
    {"letter": "B", "angle": (2 * (2 * math.pi / noOfGrades))},
    {"letter": "C", "angle": (3 * (2 * math.pi / noOfGrades))},
    {"letter": "D", "angle": (4 * (2 * math.pi / noOfGrades))},
    {"letter": "E", "angle": (5 * (2 * math.pi / noOfGrades))}
  ];

  double _angle = 0;

  double pressYPosition = 0;
  double dragYPosition = 0;
  double dragYDelta = 0;
  double prevDragYDelta = 0;
  bool _showWheelFlag = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double _angle = widget.angle;

    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: Colors.blue,
        ),
        Transform.rotate(
          angle: _angle,
          child: Center(
            child: Container(
              color: Colors.amber,
              width: 300,
              height: 300,
              child: Stack(
                  alignment: Alignment.center,
                  children: grades
                      .map(
                        (grade) => ArcText(
                          angle: grade["angle"] as double,
                          letter: grade["letter"] as String,
                        ),
                      )
                      .toList()),
            ),
          ),
        )
      ],
    );
  }
}
