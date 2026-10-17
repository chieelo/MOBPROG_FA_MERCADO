import 'package:flutter/material.dart';

const primaryBlue = Color(0xFF355C7D);
const palePeach = Color.fromARGB(220, 252, 242, 230);
const softBlue = Color(0xFFDCE8F2);
const darkBlue = Color(0xFF172B3A);

final kColorScheme = ColorScheme.fromSeed(
  seedColor: primaryBlue,
  brightness: Brightness.light,
);

final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: primaryBlue,
  brightness: Brightness.dark,
);

final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.light);

ThemeData buildTheme(
  ColorScheme colorScheme, {
  required bool isDark,
}) {
  final baseTextTheme = ThemeData(
    brightness: colorScheme.brightness,
    fontFamily: 'Poppins',
  ).textTheme;

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    fontFamily: 'Poppins',

    scaffoldBackgroundColor: isDark
        ? colorScheme.surface
        : const Color(0xFFF7F9FC),

    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimaryContainer,
        fontSize: 24,
      ),
    ),

    cardTheme: CardThemeData(
      color: isDark
          ? colorScheme.surfaceContainerHigh
          : palePeach,
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    iconTheme: IconThemeData(
      color: colorScheme.onSurface,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark
          ? colorScheme.surfaceContainerHighest
          : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.outlineVariant,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
      labelStyle: TextStyle(
        fontFamily: 'Poppins',
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: TextStyle(
        fontFamily: 'Poppins',
        color: colorScheme.onSurfaceVariant,
      ),
    ),

    textTheme: baseTextTheme.copyWith(
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
        fontSize: 24,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
        fontSize: 16,
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
        fontSize: 14,
      ),
    ).apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
      fontFamily: 'Poppins',
    ),
  );
}