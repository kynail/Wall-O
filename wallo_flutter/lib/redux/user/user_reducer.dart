import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, LoginFailedAction>(_loginFailed),
  TypedReducer<UserState, StartLoadingAction>(_startLoading),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
      user: action.user,
      isLoading: false,
      isError: false,
      errorMessage: null,
      successMessage: null);
}

UserState _loginFailed(UserState state, LoginFailedAction action) {
  print("LOGIN FAILED !");
  return state.copyWith(
      user: null,
      isLoading: false,
      isError: true,
      errorMessage: action.errorMessage,
      successMessage: null);
}

UserState _startLoading(UserState state, StartLoadingAction action) {
  return state.copyWith(
      user: null,
      isLoading: true,
      isError: false,
      errorMessage: null,
      successMessage: null);
}
