import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:lab2/pages/my_home_page.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _newColor = Colors.pinkAccent;

 void _selectColor() {
  setState(() {
    if (_newColor == Colors.pinkAccent) {
      _newColor = Colors.red;
    } else if (_newColor == Colors.red) {
      _newColor = Colors.blueAccent;
    } else {
      _newColor = Colors.pinkAccent; // vuelve al inicial
    }
  });
}


  @override
  Widget build(BuildContext context) {

  var logger = Logger();

  logger.d("Logger is working!");



    return MaterialApp(
      title: '2023479058',
      theme: ThemeData(
        fontFamily: 'Minecraft',
        colorScheme: ColorScheme.fromSeed(seedColor: _newColor),
      ),
      home: MyHomePage(
        title: '2023479058',
        onChangeColor: _selectColor,
        newColor: _newColor,
        
      ),
    );
  }
}

