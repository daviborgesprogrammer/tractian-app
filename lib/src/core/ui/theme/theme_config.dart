import 'package:flutter/material.dart';

import '../styles/colors_app.dart';

class ThemeConfig {
  ThemeConfig._();

  static final theme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsApp.i.appBar,
      elevation: 0,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.i.primary,
      primary: ColorsApp.i.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: ColorsApp.i.primary,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    ),
  );
}
