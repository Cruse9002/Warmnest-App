import 'package:flutter/material.dart';

class LightModeColors {
  static const lightPrimary = Color(0xFF684F8E);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFEAE0FF);
  static const lightOnPrimaryContainer = Color(0xFF23105F);
  static const lightSecondary = Color(0xFF635D70);
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightTertiary = Color(0xFF7E525D);
  static const lightOnTertiary = Color(0xFFFFFFFF);
  static const lightError = Color(0xFFBA1A1A);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFFFDAD6);
  static const lightOnErrorContainer = Color(0xFF410002);
  static const lightInversePrimary = Color(0xFFC6B3F7);
  static const lightShadow = Color(0xFF000000);
  static const lightSurface = Color(0xFFFAFAFA);
  static const lightOnSurface = Color(0xFF1C1C1C);
  static const lightAppBarBackground = Color(0xFFEAE0FF);
}

class DarkModeColors {
  static const darkPrimary = Color(0xFF4A9EFF);
  static const darkOnPrimary = Color(0xFFFFFFFF);
  static const darkPrimaryContainer = Color(0xFF4A9EFF);
  static const darkOnPrimaryContainer = Color(0xFFFFFFFF);
  static const darkSecondary = Color(0xFF4A9EFF);
  static const darkOnSecondary = Color(0xFFFFFFFF);
  static const darkTertiary = Color(0xFF4A9EFF);
  static const darkOnTertiary = Color(0xFFFFFFFF);
  static const darkError = Color(0xFFFFB4AB);
  static const darkOnError = Color(0xFF690005);
  static const darkErrorContainer = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFDAD6);
  static const darkInversePrimary = Color(0xFF4A9EFF);
  static const darkShadow = Color(0xFF000000);
  static const darkSurface = Color(0xFF0A192F);
  static const darkOnSurface = Color(0xFFFFFFFF);
  static const darkAppBarBackground = Color(0xFF0A192F);
}

class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 24.0;
  static const double headlineSmall = 22.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  static const double labelLarge = 16.0;
  static const double labelMedium = 14.0;
  static const double labelSmall = 12.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    inversePrimary: LightModeColors.lightInversePrimary,
    shadow: LightModeColors.lightShadow,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: LightModeColors.lightAppBarBackground,
    foregroundColor: LightModeColors.lightOnPrimaryContainer,
    elevation: 0,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    displayMedium: TextStyle(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    displaySmall: TextStyle(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
    headlineLarge: TextStyle(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    headlineMedium: TextStyle(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    headlineSmall: TextStyle(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    ),
    titleLarge: TextStyle(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    titleMedium: TextStyle(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    titleSmall: TextStyle(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    labelLarge: TextStyle(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    labelMedium: TextStyle(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    labelSmall: TextStyle(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    bodyLarge: TextStyle(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    bodyMedium: TextStyle(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    bodySmall: TextStyle(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
  ),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: DarkModeColors.darkPrimary,
    onPrimary: DarkModeColors.darkOnPrimary,
    primaryContainer: DarkModeColors.darkPrimaryContainer,
    onPrimaryContainer: DarkModeColors.darkOnPrimaryContainer,
    secondary: DarkModeColors.darkSecondary,
    onSecondary: DarkModeColors.darkOnSecondary,
    tertiary: DarkModeColors.darkTertiary,
    onTertiary: DarkModeColors.darkOnTertiary,
    error: DarkModeColors.darkError,
    onError: DarkModeColors.darkOnError,
    errorContainer: DarkModeColors.darkErrorContainer,
    onErrorContainer: DarkModeColors.darkOnErrorContainer,
    inversePrimary: DarkModeColors.darkInversePrimary,
    shadow: DarkModeColors.darkShadow,
    surface: DarkModeColors.darkSurface,
    onSurface: DarkModeColors.darkOnSurface,
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkModeColors.darkAppBarBackground,
    foregroundColor: DarkModeColors.darkOnPrimaryContainer,
    elevation: 0,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    displayMedium: TextStyle(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    displaySmall: TextStyle(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    ),
    headlineLarge: TextStyle(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    headlineMedium: TextStyle(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    headlineSmall: TextStyle(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    ),
    titleLarge: TextStyle(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    titleMedium: TextStyle(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    titleSmall: TextStyle(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    labelLarge: TextStyle(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    labelMedium: TextStyle(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    labelSmall: TextStyle(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    ),
    bodyLarge: TextStyle(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    bodyMedium: TextStyle(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
    bodySmall: TextStyle(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
      fontFamily: 'Inter',
    ),
  ),
);
