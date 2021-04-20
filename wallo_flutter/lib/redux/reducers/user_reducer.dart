import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, UpdateUserAction>(_updateUser),
  TypedReducer<UserState, SetCamerasAction>(_setCameras),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
    user: action.user,
  );
}

UserState _updateUser(UserState state, UpdateUserAction action) {
  return state.copyWith(
    user: action.user,
  );
}

UserState _setCameras(UserState state, SetCamerasAction action) {
  return state.copyWith(
    cameras: action.cameras,
  );
}
