import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static ThemeRepository? _instance;
  static bool get initialized => _instance != null;

  static const Color defaultSeedColor = Colors.deepPurple;

  late final SharedPreferences _sharedPreferences;

  ThemeRepository._internal();

  factory ThemeRepository() {
    assert(initialized, "Call init() first!");
    return _instance!;
  }

  static void init(SharedPreferences sharedPreferences) {
    assert(!initialized, "Already initialized");
    _instance ??= ThemeRepository._internal();
    _instance!._sharedPreferences = sharedPreferences;
  }

  static void dispose() {
    _instance = null;
  }

  Color getThemeSeedColor() {
    final seedColorValue = _sharedPreferences.getInt("themeSeedColorValue");
    return seedColorValue == null ? defaultSeedColor : Color(seedColorValue);
  }

  Future<void> setThemeSeedColor(Color color) async {
    await _sharedPreferences.setInt("themeSeedColorValue", color.toARGB32());
  }

  ThemeMode getThemeMode() {
    var mode = _sharedPreferences.getInt("themeMode") ?? 0;
    mode = (mode > ThemeMode.values.length) ? 0 : mode;
    
    return ThemeMode.values[mode];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _sharedPreferences.setInt("themeMode", mode.index);
  }
}
