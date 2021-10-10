import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/new_achievement.dart';
import 'package:wallo_flutter/models/viewmodels/home_viewModel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/widgets/achievement/achievement_layout.dart';
import 'package:wallo_flutter/widgets/achievement/modal_confetti.dart';
import 'package:wallo_flutter/widgets/messenger_handler.dart';

import '../views/home/home.dart';

GlobalKey<ModalConfettiState> globalKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildContent(HomeViewModel viewModel, double appBarHeight) {
    return viewModel.cameras != null
        ? !viewModel.isCameraLoading
            ? Stack(
                children: [
                  MessengerHandler(
                    child: Home(
                      onLeaderboardTap: () => viewModel.getLeaderboard(),
                      user: viewModel.user,
                      cameraController: viewModel.cameraController,
                      appBarHeight: appBarHeight,
                    ),
                  ),
                  ModalConfetti(
                    key: globalKey,
                    child: AchievementLayout(
                      globalKey: globalKey,
                      newAchievement: viewModel.newAchievement,
                      onClose: () => viewModel.newAchievementShowed(),
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator())
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
        body: new StoreConnector<AppState, HomeViewModel>(
          distinct: true,
          converter: (store) => HomeViewModel.fromStore(store),
          builder: (_, viewModel) => buildContent(viewModel, appBarheight),
          onInitialBuild: (viewModel) {
            viewModel.getAquadex();
            viewModel.getAchievements();
          },
          onWillChange: (oldViewModel, viewModel) {
            if (viewModel.newAchievement != null &&
                viewModel.newAchievement != NewAchievement.empty()) {
              globalKey.currentState.playNewAchievement();
            }
          },
        ),
      ),
    );
  }
}
