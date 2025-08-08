import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themed_app/Utils/string_extensions.dart';
import 'package:themed_app/main.dart';
import 'package:themed_app/theme_manager.dart';

class ThemeModePicker extends StatelessWidget {
  const ThemeModePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    debugPrint(ThemeMode.values[0].name);
    return Column(
      children: [
        ...ThemeMode.values.map((themeMode) {
          return RadioListTile(
            value: themeMode,
            groupValue: themeManager.themeMode,
            onChanged: (mode) {
              if (mode != null) themeManager.updateThemeMode(mode);
            },
            title: Text(themeMode.name.capitalizeFirst()),
            contentPadding: EdgeInsets.all(0),
          );
        }),
      ],
    );
  }
}
