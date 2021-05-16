import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/route_generator.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await DotEnv.load();
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
          navigatorKey: Keys.navKey,
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
