import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPreferencesService {
  static const String keySize = 'gridSize';
  static const String keySelectedColor = 'selectedColor';

  Future<void> saveGridSize(int size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keySize, size);
  }

  Future<int> loadGridSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keySize) ?? 16;
  }

  Future<void> saveSelectedColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keySelectedColor, color.value);
  }

  Future<Color> loadSelectedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? colorValue = prefs.getInt(keySelectedColor);
    return colorValue != null ? Color(colorValue) : Colors.pinkAccent;
  }
}
