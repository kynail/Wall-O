import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/game_actions.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

import '../user.dart';

class LeaderboardViewModel {
  final MessengerState messenger;
  final User user;
  final List<User> leaderboard;

  final Function() getLeaderboard;

  LeaderboardViewModel(
      {this.messenger, this.user, this.leaderboard, this.getLeaderboard});

  static LeaderboardViewModel fromStore(Store<AppState> store) {
    return LeaderboardViewModel(
        messenger: store.state.messengerState,
        user: store.state.userState.user,
        leaderboard: store.state.gameState.leaderboard,
        getLeaderboard: () => store.dispatch(getLeaderboardAction()));
  }
}
