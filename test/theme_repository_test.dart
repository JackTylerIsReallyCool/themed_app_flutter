import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:themed_app/theme_repository.dart';

void main() {
  test("Theme repository is singleton", () async {
    SharedPreferences.setMockInitialValues({});
    ThemeRepository.init(await SharedPreferences.getInstance());
    
    final repo1 = ThemeRepository();
    final repo2 = ThemeRepository();

    expect(repo1, repo2);

    ThemeRepository.dispose();
  });

  test("Can get themeSeedColor", () async {
    const expectedColor = Colors.red;
    SharedPreferences.setMockInitialValues({
      "themeSeedColorValue": expectedColor.toARGB32(),
    });
    ThemeRepository.init(await SharedPreferences.getInstance());

    final actualColor = ThemeRepository().getThemeSeedColor();
    expect(actualColor.toARGB32(), expectedColor.toARGB32());
    ThemeRepository.dispose();
  });

  test("themeSeedColor not set returns default color", () async {
    SharedPreferences.setMockInitialValues({});
    ThemeRepository.init(await SharedPreferences.getInstance());

    final actualColor = ThemeRepository().getThemeSeedColor();

    expect(actualColor.toARGB32(), ThemeRepository.defaultSeedColor.toARGB32());

    ThemeRepository.dispose();
  });

  test("Can set themeSeedColor", () async {
    const expectedColor = Colors.red;

    SharedPreferences.setMockInitialValues({});
    ThemeRepository.init(await SharedPreferences.getInstance());

    await ThemeRepository().setThemeSeedColor(expectedColor);
    final actualColor = ThemeRepository().getThemeSeedColor();

    expect(actualColor.toARGB32(), expectedColor.toARGB32());

    ThemeRepository.dispose();
  });
}
