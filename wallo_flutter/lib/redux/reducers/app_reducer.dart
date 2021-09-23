import 'package:wallo_flutter/redux/reducers/achievement_reducer.dart';
import 'package:wallo_flutter/redux/reducers/fish_reducer.dart';
import 'package:wallo_flutter/redux/reducers/game_reducer.dart';
import 'package:wallo_flutter/redux/reducers/messenger_reducer.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    messengerState: messengerReducer(state.messengerState, action),
    userState: userReducer(state.userState, action),
    gameState: gameReducer(state.gameState, action),
    fishState: fishReducer(state.fishState, action),
    achievementState: achievementReducer(state.achievementState, action),
  );
}
