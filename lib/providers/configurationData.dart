import 'package:flutter/material.dart';
import 'package:lab2/services/shared_preferences_service.dart';
import 'package:logger/logger.dart';





class AppData extends ChangeNotifier {
  final SharedPreferencesService _prefsService;
  final Logger _logger = Logger();

  AppData(this._prefsService) {
    _loadPreferences(); 
  }

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

  Future<void> setSize(int newSize) async {
    _logger.i("Se ha guardado el tamaño de la grilla: $newSize");
    _size = newSize;
    await _prefsService.saveGridSize(newSize);
    notifyListeners();
  }

  set size(int newSize) {
    _size = newSize;
    notifyListeners();
  }

  Color _selectColor = Colors.pinkAccent;
  Color get selectedColor => _selectColor;

  Future<void> setColor(Color newColor) async {
    _logger.i("Se ha guardado el color nuevo: $newColor");
    _selectColor = newColor;
    await _prefsService.saveSelectedColor(newColor);
    notifyListeners();
  }

 
  Future<void> _loadPreferences() async {
    _logger.i("Se han cargado los cambios guardados");
    _size = await _prefsService.loadGridSize();
    _selectColor = await _prefsService.loadSelectedColor();
    notifyListeners();
  }
}
