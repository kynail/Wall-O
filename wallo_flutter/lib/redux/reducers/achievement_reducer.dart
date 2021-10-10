import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/new_achievement.dart';
import 'package:wallo_flutter/redux/actions/achievement_actions.dart';
import 'package:wallo_flutter/redux/state/achievement_state.dart';

final achievementReducer = combineReducers<AchievementState>([
  TypedReducer<AchievementState, SetNewAchievementAction>(_setNewAchievement),
  TypedReducer<AchievementState, NewAchievementShowedAction>(
    _newAchievementShowed,
  ),
]);

AchievementState _setNewAchievement(
    AchievementState state, SetNewAchievementAction action) {
  return state.copyWith(
    newAchievement: action.newAchievement,
  );
}

AchievementState _newAchievementShowed(
    AchievementState state, NewAchievementShowedAction action) {
  return state.copyWith(
    newAchievement: NewAchievement.empty(),
  );
}
