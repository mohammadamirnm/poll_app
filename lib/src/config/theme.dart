import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(LightThemeColors.primary),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return LightThemeColors.primary.withOpacity(0.3);
            } else {
              return LightThemeColors.primary;
            }
          },
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) => LightThemeColors.primary),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: LightThemeColors.titleTextColor),
      backgroundColor: LightThemeColors.background,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: LightThemeColors.titleTextColor,
        fontSize: 16,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        fontSize: 12,
        color: LightThemeColors.textFieldTextColor,
        height: 16 / 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    fontFamily: GoogleFonts.openSans().fontFamily,
    scaffoldBackgroundColor: LightThemeColors.background,
    colorScheme: const ColorScheme.light(
      background: LightThemeColors.background,
      primary: LightThemeColors.primary,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: LightThemeColors.titleTextColor,
        fontSize: 32,
        height: 36 / 32,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: LightThemeColors.bodyTextColor,
        fontSize: 14,
        height: 20 / 14,
      ),
      bodySmall: TextStyle(
        color: LightThemeColors.labelTextColor,
        fontSize: 14,
        height: 20 / 14,
      ),
      labelMedium: TextStyle(
        color: LightThemeColors.buttonTextColor,
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w700,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}
