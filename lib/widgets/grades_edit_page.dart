import 'dart:math' as math;

import 'package:flutter/material.dart';
import './grade_wheel.dart';

class GradesEditPage extends StatefulWidget {
  const GradesEditPage({Key? key}) : super(key: key);

  @override
  State<GradesEditPage> createState() => _GradesEditPageState();
}

class _GradesEditPageState extends State<GradesEditPage> {
  bool _showWheelFlag = false;
  double pressYPosition = 0;
  double dragYPosition = 0;
  double dragYDelta = 0;
  double prevDragYDelta = 0;
  double _angle = 0;
  double activeId = 0;

  // Map<int, double> subs = {
  //   1: 0.5,
  //   2: 1,
  //   3: 2,
  // };

  List<Map<String, Object>> subs = [
    {"initAngle": 0, "id": 0, "grade": ""},
    {"initAngle": 1.5, "id": 1, "grade": ""},
    {"initAngle": 2, "id": 2, "grade": ""},
  ];

  List<String> gradeList = ["E", "A", "B", "C", "D"];

  bool switchFromLow = false;
  bool switchFromHigh = false;
  double baseVal = 0;
  double varVal = 0;
  double angleDeg = 0;
  int noOfGrades = 5;
  double angleDegMod = 0;
  double sectionAngle = 0;
  int indentNo = 0;

  @override
  Widget build(BuildContext context) {
    void _showWheel(int id) {
      // print("show");
      setState(() {
        _showWheelFlag = true;
      });
    }

    void _hideWheel(int id) {
      setState(() {
        _showWheelFlag = false;
      });
    }

    void _rotateWheel(int id, double dragYChange) {
      setState(() {
        _angle = (dragYChange / 700) * 4 * math.pi;
        angleDeg = -(180 * _angle) / math.pi;
        // print(_angle);
        var rawAngle = angleDeg;
        double angleRatio = 0;
        double curveRatio = 0;
        var piMod = rawAngle % (360 / noOfGrades);
        angleRatio = piMod / (360 / noOfGrades);
        curveRatio = 1 / (1 + math.pow((angleRatio / (1 - angleRatio)), -6));
        baseVal = rawAngle >= 0
            ? (rawAngle / (360 / noOfGrades)).truncate() * (360 / noOfGrades)
            : ((rawAngle / (360 / noOfGrades)).truncate() - 1) *
                (360 / noOfGrades);
        varVal = rawAngle >= 0
            ? (rawAngle - baseVal) * curveRatio
            : (baseVal - rawAngle) * curveRatio;
        angleDeg = rawAngle >= 0 ? baseVal + varVal : baseVal - varVal;
        _angle = -angleDeg * (math.pi / 180);

        // To find what is selected
        angleDegMod = angleDeg % 360;
        sectionAngle = 360 / noOfGrades;
        indentNo = (angleDegMod / sectionAngle).round() % noOfGrades;
        print("$angleDeg   $sectionAngle   $indentNo");

        subs[id]["initAngle"] = angleDeg;
        subs[id]["grade"] = gradeList[indentNo];
        _showWheelFlag = true;
      });
    }

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: subs
              .map(
                (sub) => GestureDetector(
                  onVerticalDragUpdate: (details) {
                    dragYPosition = details.globalPosition.dy;
                    dragYDelta = dragYPosition - pressYPosition;
                    _rotateWheel(sub["id"] as int, dragYDelta);
                    prevDragYDelta = dragYDelta;
                  },
                  onTapDown: (details) {
                    pressYPosition = details.globalPosition.dy;
                    _showWheel(sub["id"] as int);
                  },
                  onVerticalDragEnd: (details) {
                    _hideWheel(sub["id"] as int);
                  },
                  onTapUp: (details) {
                    _hideWheel(sub["id"] as int);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.amber,
                    margin: EdgeInsets.all(50),
                    child: Text(sub["grade"] as String),
                  ),
                ),
              )
              .toList(),
        ),
        _showWheelFlag ? GradeWheel(angle: _angle) : Container(),
      ],
    );
  }
}
