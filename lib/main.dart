import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themed_app/UI/Settings/Theme/theme_color_picker.dart';
import 'package:themed_app/UI/Settings/Theme/theme_mode_picker.dart';
import 'package:themed_app/UI/Settings/Theme/theme_settings_screen.dart';
import 'package:themed_app/theme_manager.dart';
import 'package:themed_app/theme_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ThemeRepository.init(await SharedPreferences.getInstance());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager(ThemeRepository())),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    return MaterialApp(
      theme: themeManager.theme,
      darkTheme: themeManager.darkTheme,
      themeMode: themeManager.themeMode,
      title: 'App',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.read<ThemeManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text("App bar"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          PopupMenuButton(
            //icon: Icon(Icons.more),
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text("Theme Settings"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ThemeSettingsPage()),
                    );
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Hello"),
              FilledButton(
                onPressed: () => themeManager.updateSeedColor(Colors.amber),
                child: Text("Change Theme"),
              ),
              FilledButton(
                onPressed: () => themeManager.resetTheme(),
                child: Text("Reset Theme"),
              ),
              FilledButton(
                onPressed: () => themeManager.updateThemeMode(ThemeMode.light),
                child: Text("Light Theme"),
              ),
              FilledButton(
                onPressed: () => themeManager.updateThemeMode(ThemeMode.dark),
                child: Text("Dark Theme"),
              ),
              FilledButton(
                onPressed: () => themeManager.updateThemeMode(ThemeMode.system),
                child: Text("System Theme"),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ThemeColorPicker(),
              ),
              ThemeModePicker(),
            ],
          ),
        ),
      ),
    );
  }
}
