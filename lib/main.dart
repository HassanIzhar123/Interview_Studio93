import 'package:flutter/material.dart';

import 'Screens/normal_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Scaffold(
      //   body: Center(
      //     child: Container(
      //       height: 100,
      //       width: 100,
      //       decoration: BoxDecoration(
      //         color: Colors.blue,
      //         borderRadius: BorderRadius.only(
      //           topRight: Radius.circular(40),
      //           topLeft: Radius.circular(10.0),
      //           bottomLeft: Radius.circular(10.0),
      //           bottomRight: Radius.circular(10.0),
      //         ),
      //         border: Border.all(
      //           width: 3,
      //           color: Colors.green,
      //           style: BorderStyle.solid,
      //         ),
      //       ),
      //       child: Center(
      //         child: Text(
      //           "Hello",
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      home: const Scaffold(body: NormalMealsScreen()),
    );
  }
}
