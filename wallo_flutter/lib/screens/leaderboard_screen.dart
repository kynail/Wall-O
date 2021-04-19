import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/leaderboard_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/leaderboard.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

import '../theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key key}) : super(key: key);

  Widget buildContent(LeaderboardViewModel viewModel) {
    return viewModel.leaderboard == null
        ? Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(strokeWidth: 2))
        : Leaderboard(leaderboard: viewModel.leaderboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Classement"),
            iconTheme: IconThemeData(color: Colors.white)),
        drawer: CustomDrawer(),
        backgroundColor: AppTheme.secondaryColor,
        body: new StoreConnector<AppState, LeaderboardViewModel>(
          distinct: true,
          converter: (store) => LeaderboardViewModel.fromStore(store),
          onInitialBuild: (viewModel) => viewModel.getLeaderboard(),
          builder: (_, viewModel) => buildContent(viewModel),
        ));
  }
}
