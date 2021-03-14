import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class AppTheme {
  AppTheme();

  final MaterialColor primarySwatch = createMaterialColor(Color(0xFF5ACCBF));
  final Color primaryColor = Color(0xFF5ACCBF);
  final Color secondaryColor = Color(0xFFFFFEF1);
  final Color errorColor = Color(0xffF44336);
  final Color secondaryText = Color(0xff606060);
  final Color lightGrey = Color(0xffc6c6c6);
}
