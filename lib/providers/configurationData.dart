import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0; 
  int get counter => _counter; 

  void incrementCounter() {
    _counter++;
    notifyListeners(); 
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }

  int _size = 16;
  int get size => _size;

  void setSize(int newSize) {
    _size = newSize;
    notifyListeners();
  }

  set size(int newSize) {
    _size = newSize;
    notifyListeners();
  }

  Color _selectcolor = Colors.pinkAccent;
  Color get selectedColor => _selectcolor;

  void setColor(Color newcolor){
    _selectcolor = newcolor;
    notifyListeners();
  }


}
