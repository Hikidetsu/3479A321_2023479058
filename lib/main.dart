import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:lab2/pages/my_home_page.dart';
import 'package:lab2/pages/list_art.dart';
import 'package:lab2/pages/pixel_art_screen.dart';
import 'package:lab2/providers/configurationData.dart';
import 'package:lab2/services/shared_preferences_service.dart';

void main() {
  
  final prefsService = SharedPreferencesService();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(prefsService), 
      child: const MyApp(),
    ),
  );
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
