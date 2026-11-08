import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  AppTheme._();

  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: AppColors.maroon,
  ).copyWith(
    primary: AppColors.maroon,
    onPrimary: AppColors.lightPink,
    surface: AppColors.lightBackground,
    onSurface: AppColors.maroon,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.maroon,
    brightness: Brightness.dark,
  ).copyWith(
    primary: AppColors.lightPink,
    onPrimary: AppColors.maroon,
    surface: AppColors.darkBackground,
    onSurface: AppColors.lightPink,
  );

  static ThemeData get light => _build(_lightScheme);
  static ThemeData get dark => _build(_darkScheme);

  static ThemeData _build(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.primary,
        surfaceTintColor: scheme.primary, 
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputRadius),
        ),
      ),

      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        ),
      ),

      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),

      textTheme: ThemeData().textTheme.copyWith(
            headlineMedium: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface,
            ),
            titleLarge: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
            titleSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: scheme.onSurface,
            ),
          ),
    );
  }
}