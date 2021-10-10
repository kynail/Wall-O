import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallo_flutter/models/achievement.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/services/game_service.dart';

ThunkAction getLeaderboardAction() {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new StartLoadingAction());
      leaderboardRequest().then((leaderboard) {
        store.dispatch(new SetLeaderboardAction(leaderboard));
      }, onError: (errorMessage) {
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

ThunkAction getAchievementAction() {
  return (Store store) async {
    new Future(() async {
      getAchievementRequest().then((achivements) {
        return store.dispatch(
          SetAchievementsAction(achivements),
        );
      }, onError: (errorMessage) {
        store.dispatch(new RequestFailedAction(errorMessage));
      });
    });
  };
}

class SetLeaderboardAction {
  List<User> leaderboard;

  SetLeaderboardAction(this.leaderboard);
}

class SetAchievementsAction {
  List<Achievement> achievements;

  SetAchievementsAction(this.achievements);
}
