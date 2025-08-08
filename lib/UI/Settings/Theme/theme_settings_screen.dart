import 'package:flutter/material.dart';
import 'package:themed_app/UI/Settings/Theme/theme_color_picker.dart';
import 'package:themed_app/UI/Settings/Theme/theme_mode_picker.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(title: Text("Theme Settings")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 0,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text("Theme mode", style: titleTextStyle),
                    ThemeModePicker(),
                  ],
                ),
              ),
              //Divider(),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text("Theme color", style: titleTextStyle),
                    ThemeColorPicker(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
