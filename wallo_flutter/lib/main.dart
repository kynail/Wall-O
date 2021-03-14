import 'package:flutter/material.dart';
import 'package:wallo_flutter/route_generator.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() async {
  await Redux.init();
  runApp(WallO());
}

class WallO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: Redux.store,
        child: MaterialApp(
          title: 'Wall-O',
          theme: ThemeData(
            primarySwatch: AppTheme().primarySwatch,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.white)),
          ),
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
