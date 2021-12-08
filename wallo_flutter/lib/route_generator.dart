import 'package:flutter/material.dart';
import 'package:wallo_flutter/screens/forget_password_screen.dart';
import 'package:wallo_flutter/screens/home_screen.dart';
import 'package:wallo_flutter/screens/login_screen.dart';
import 'package:wallo_flutter/screens/reset_password_screen.dart';
import 'package:wallo_flutter/screens/signin_screen.dart';
import 'package:wallo_flutter/screens/webview_screen.dart';
import 'package:wallo_flutter/widgets/CameraManager.dart';
import 'package:wallo_flutter/widgets/LifeCycleManager.dart';

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
    List<String> pathComponents = settings.name.split('/');
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.signIn:
        return MaterialPageRoute(builder: (context) => SigninScreen());
      case Routes.forget:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => LifeCycleManager(
            child: CameraManager(
              child: HomeScreen(),
            ),
          ),
        );
      case Routes.webview:
        return MaterialPageRoute(builder: (context) => WebviewScreen());
      default:
        if (pathComponents[1] == "reset")
          return MaterialPageRoute(
            builder: (context) =>
                ResetPasswordScreen(token: pathComponents.last),
          );
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
