import 'package:flutter/material.dart';
import './widgets/grade_wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double angle = 0;
  bool _showWheelFlag = false;

  void _showWheel() {
    print("dd");
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          GestureDetector(
            onLongPress: () => _showWheel(),
            onLongPressEnd: (_) => _hideWheel(),
            child: Container(
              height: 20,
              width: 20,
              color: Colors.black,
            ),
          ),
          Container(
            child: _showWheelFlag ? GradeWheel() : Container(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
