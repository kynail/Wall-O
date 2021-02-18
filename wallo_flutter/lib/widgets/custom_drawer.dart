import 'package:flutter/material.dart';
import 'package:wallo_flutter/theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final theme = AppTheme();
    return Stack(
      children: [
        Container(
          color: theme.primaryColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuButton(
                  text: "Mon profil", theme: theme, redirectRoute: "/profile"),
              MenuButton(
                  text: "Analyser une photo",
                  theme: theme,
                  redirectRoute: "/home"),
              MenuButton(
                  text: "Mon Aquadex",
                  theme: theme,
                  redirectRoute: "/aquarium"),
              MenuButton(
                  text: "Classements",
                  theme: theme,
                  redirectRoute: "/classement"),
              MenuButton(text: "Aide", theme: theme, redirectRoute: "/contact"),
            ],
          ),
        ),
        Positioned(
            top: statusBarHeight,
            right: 12,
            child: IconButton(
              color: Colors.white,
              iconSize: 40,
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ))
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton(
      {Key key,
      @required this.text,
      @required this.theme,
      @required this.redirectRoute})
      : super(key: key);

  final AppTheme theme;
  final String text;
  final String redirectRoute;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.65,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Container(
          height: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: theme.secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0))),
            child: Text(text,
                style:
                    TextStyle(color: theme.primarySwatch[600], fontSize: 25)),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(redirectRoute);
            },
          ),
        ),
      ),
    );
  }
}
