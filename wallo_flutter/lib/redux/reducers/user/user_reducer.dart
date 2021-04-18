import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/state/user/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
    user: action.user,
  );
}
