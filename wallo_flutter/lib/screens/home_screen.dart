import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/home_viewModel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/widgets/messenger_handler.dart';

import '../views/home/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildContent(HomeViewModel viewModel, double appBarHeight) {
    return viewModel.cameras != null
        ? MessengerHandler(
            child: Home(
            user: viewModel.user,
            camera: viewModel.selectedCamera,
            appBarHeight: appBarHeight,
          ))
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text('Wall-O'),
    );

    final appBarheight = 0.0;

    print("APPBAR ${appBar.preferredSize.height}");
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          drawer: CustomDrawer(),
          // appBar: appBar,
          body: new StoreConnector<AppState, HomeViewModel>(
            distinct: true,
            converter: (store) => HomeViewModel.fromStore(store),
            builder: (_, viewModel) => buildContent(viewModel, appBarheight),
            onInitialBuild: (viewModel) {
              viewModel.getCameras();
              viewModel.getAquadex();
            },
          )),
    );
  }
}
