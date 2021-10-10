import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/game_actions.dart';
import 'package:wallo_flutter/redux/state/game_state.dart';

final gameReducer = combineReducers<GameState>([
  TypedReducer<GameState, SetLeaderboardAction>(_setLeaderboard),
  TypedReducer<GameState, SetAchievementsAction>(_setAchievements),
]);

GameState _setLeaderboard(GameState state, SetLeaderboardAction action) {
  return state.copyWith(
    leaderboard: action.leaderboard,
  );
}

GameState _setAchievements(GameState state, SetAchievementsAction action) {
  return state.copyWith(
    achievements: action.achievements,
  );
}
