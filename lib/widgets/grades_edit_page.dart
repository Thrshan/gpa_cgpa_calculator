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
    {"initAngle": 0, "id": 0},
    {"initAngle": 1.5, "id": 1},
    {"initAngle": 2, "id": 2},
  ];

  @override
  Widget build(BuildContext context) {
    void _showWheel(int id) {
      print("show");
      setState(() {
        _showWheelFlag = true;
      });
    }

    void _hideWheel(int id) {
      setState(() {
        _showWheelFlag = false;
      });
    }

    void _rotateWheel(int id, double rotation) {
      setState(() {
        subs[id]["initAngle"] = rotation;
        _showWheelFlag = true;
        _angle = rotation;
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
                    dragYDelta = (((dragYPosition - pressYPosition) / 700) *
                        3 *
                        math.pi);
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
                    child: Text(sub["initAngle"].toString()),
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
