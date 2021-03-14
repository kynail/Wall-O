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
  static const Color primaryColor = Color(0xFF5ACCBF);
  static const Color secondaryColor = Color(0xFFFFFEF1);
  static const Color errorColor = Color(0xffF44336);
  static const Color secondaryText = Color(0xff606060);
  static const Color lightGrey = Color(0xffc6c6c6);

  //Palette
  static const Color colorA = Color(0xff2B8076);
  static const Color colorB = Color(0xff8AFFF1);
  static const Color colorC = Color(0xff5ACCBF);
  static const Color colorD = Color(0xff803D1F);
  static const Color colorE = Color(0xffCC7D5A);
}
