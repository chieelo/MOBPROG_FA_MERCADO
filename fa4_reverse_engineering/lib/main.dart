import 'package:fa4_reverse_engineering/commons/app_theme.dart';
import 'package:fa4_reverse_engineering/screens/login_screen.dart';
import 'package:fa4_reverse_engineering/commons/theme_notif.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const FireflyApp());
}

class FireflyApp extends StatelessWidget {
  const FireflyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Firefly',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: currentMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}
