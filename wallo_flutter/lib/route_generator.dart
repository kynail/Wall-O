import 'package:flutter/material.dart';
import 'package:wallo_flutter/screens/aquarium.dart';
import 'package:wallo_flutter/screens/classement.dart';
import 'package:wallo_flutter/screens/contact.dart';
import 'package:wallo_flutter/screens/home.dart';
import 'package:wallo_flutter/screens/login.dart';
import 'package:wallo_flutter/screens/sign_in.dart';
import 'package:wallo_flutter/screens/profile/profile.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => SignIn());
      case "/login":
        return MaterialPageRoute(builder: (context) => Login());
      case "/home":
        return MaterialPageRoute(builder: (context) => Home());
      case "/profile":
        return MaterialPageRoute(builder: (context) => Profile());
      case "/aquarium":
        return MaterialPageRoute(builder: (context) => Aquarium());
      case "/contact":
        return MaterialPageRoute(builder: (context) => Contact());
      case "/classement":
        return MaterialPageRoute(builder: (context) => Classement());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Page not found'),
        ),
        body: Center(
          child: Text("this page doesn't exist :(",
              style: TextStyle(fontSize: 20)),
        ),
      );
    });
  }
}
