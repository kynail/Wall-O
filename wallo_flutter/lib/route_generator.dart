import 'package:flutter/material.dart';
import 'package:wallo_flutter/screens/aquarium.dart';
import 'package:wallo_flutter/screens/leaderboard_screen.dart';
import 'package:wallo_flutter/views/leaderboard.dart';
import 'package:wallo_flutter/screens/contact.dart';
import 'package:wallo_flutter/screens/forget_password.dart';
import 'package:wallo_flutter/screens/home.dart';
import 'package:wallo_flutter/screens/login_screen.dart';
import 'package:wallo_flutter/screens/profile_screen.dart';
import 'package:wallo_flutter/screens/reset_password_form.dart';
import 'package:wallo_flutter/screens/signin_screen.dart';
import 'package:wallo_flutter/screens/webview_screen.dart';
import 'package:wallo_flutter/views/profile/profile.dart';

class Routes {
  static const loginScreen = "/";
  static const signIn = "/signin";
  static const forget = "/forget";
  static const reset = "/reset";
  static const home = "/home";
  static const profile = "/profile";
  static const aquarium = "/aquarium";
  static const contact = "/contact";
  static const classement = "/classement";
  static const webview = "/webview";
}

class Keys {
  static final navKey = new GlobalKey<NavigatorState>();
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    List<String> pathComponents = settings.name.split('/');
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.signIn:
        return MaterialPageRoute(builder: (context) => SigninScreen());
      case Routes.forget:
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case Routes.reset:
        return MaterialPageRoute(builder: (context) => ResetPasswordForm());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => Home());
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case Routes.aquarium:
        return MaterialPageRoute(builder: (context) => Aquarium());
      case Routes.contact:
        return MaterialPageRoute(builder: (context) => Contact());
      case Routes.classement:
        return MaterialPageRoute(builder: (context) => LeaderboardScreen());
      case Routes.webview:
        return MaterialPageRoute(builder: (context) => WebviewScreen());
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
