import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/models/viewmodels/leaderboard_viewmodel.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/views/leaderboard.dart';

import '../theme.dart';

class LeaderboardScreen extends StatelessWidget {
  final Function() onCloseArrowTap;

  const LeaderboardScreen({
    Key key,
    @required this.onCloseArrowTap,
  }) : super(key: key);

  Widget buildContent(LeaderboardViewModel viewModel, double statusBarHeight) {
    return viewModel.leaderboard == null
        ? Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Leaderboard(
              leaderboard: viewModel.leaderboard,
              onCloseArrowTap: onCloseArrowTap,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: new StoreConnector<AppState, LeaderboardViewModel>(
        distinct: true,
        converter: (store) => LeaderboardViewModel.fromStore(store),
        // onInitialBuild: (viewModel) => viewModel.getLeaderboard(),
        builder: (_, viewModel) {
          return buildContent(viewModel, statusBarHeight);
        },
      ),
    );
  }
}
