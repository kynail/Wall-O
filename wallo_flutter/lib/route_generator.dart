import 'package:flutter/material.dart';
import 'package:wallo_flutter/screens/aquarium.dart';
import 'package:wallo_flutter/screens/classement.dart';
import 'package:wallo_flutter/screens/contact.dart';
import 'package:wallo_flutter/screens/forget_password.dart';
import 'package:wallo_flutter/screens/home.dart';
import 'package:wallo_flutter/screens/login_screen.dart';
import 'package:wallo_flutter/screens/reset_password_form.dart';
import 'package:wallo_flutter/screens/sign_in.dart';
import 'package:wallo_flutter/screens/profile/profile.dart';
import 'package:wallo_flutter/widgets/webview.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    List<String> pathComponents = settings.name.split('/');
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case "/signin":
        return MaterialPageRoute(builder: (context) => SignIn());
      case "/forget":
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case "/reset":
        return MaterialPageRoute(builder: (context) => ResetPasswordForm());
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
      case "/webview":
        return MaterialPageRoute(builder: (context) => Webview());
      default:
        if (pathComponents[1] == "reset")
          return MaterialPageRoute(
              builder: (context) =>
                  ResetPasswordForm(token: pathComponents.last));
        else
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
