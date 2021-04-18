import 'package:wallo_flutter/redux/reducers/messenger/messenger_reducer.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/reducers/user/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    messengerState: messengerReducer(state.messengerState, action),
    userState: userReducer(state.userState, action),
  );
}
