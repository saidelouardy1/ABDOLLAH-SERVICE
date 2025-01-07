import 'package:flutter/material.dart';

class AppTheme {
  static final costomLight = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF0D6EFD)
    )
  );
  static final costomDark = ThemeData(
    scaffoldBackgroundColor: Color(0xFF0B192C),
    colorScheme: ColorScheme.dark(
       primary: const Color(0xFF0D6EFD)
    )
  );
}