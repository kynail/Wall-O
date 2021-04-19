import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, UpdateUserAction>(_updateUser),
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
