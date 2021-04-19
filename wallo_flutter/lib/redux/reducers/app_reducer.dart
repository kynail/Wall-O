import 'package:wallo_flutter/redux/reducers/game_reducer.dart';
import 'package:wallo_flutter/redux/reducers/messenger_reducer.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      messengerState: messengerReducer(state.messengerState, action),
      userState: userReducer(state.userState, action),
      gameState: gameReducer(state.gameState, action));
}
