
import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/home.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/commons/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Reading List',
          theme: buildTheme(
            kColorScheme,
            isDark: false,
          ),
          darkTheme: buildTheme(
            kDarkColorScheme,
            isDark: true,
          ),
          themeMode: themeMode,
          home: const Home(),
        );
      },
    );
  }
}