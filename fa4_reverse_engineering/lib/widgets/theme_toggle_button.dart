import 'package:fa4_reverse_engineering/commons/theme_notif.dart';
import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_medium),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {
        themeNotifier.value = themeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
      },
    );
  }
}
