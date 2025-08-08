import 'package:flutter/material.dart';
import 'package:themed_app/theme_repository.dart';

class ThemeManager extends ChangeNotifier {
  final ThemeRepository _themeRepository;

  late Color _seedColor;
  Color get seedColor => _seedColor;

  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  ThemeData get theme => ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
  );

  ThemeData get darkTheme => ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
  );

  ThemeManager(this._themeRepository) {
    _seedColor = _themeRepository.getThemeSeedColor();
    _themeMode = _themeRepository.getThemeMode();
  }

  Future<void> updateSeedColor(Color color) async {
    _seedColor = color;
    notifyListeners();
    await _themeRepository.setThemeSeedColor(color);
  }

  Future<void> resetTheme() async {
    await updateSeedColor(ThemeRepository.defaultSeedColor);
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _themeRepository.setThemeMode(mode);
  }
}
