import 'package:flutter/material.dart';
import 'package:wallo_flutter/route_generator.dart';
import 'package:wallo_flutter/theme.dart';

void main() {
  runApp(WallO());
}

class WallO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = new AppTheme();
    return MaterialApp(
      title: 'Wall-O',
      theme: ThemeData(
        primarySwatch: theme.primarySwatch,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
