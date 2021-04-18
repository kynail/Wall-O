import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, LoginFailedAction>(_loginFailed),
  TypedReducer<UserState, StartLoadingAction>(_startLoading),
  TypedReducer<UserState, MarkSnackbarHasHandledAction>(
      _markSnackbarHasHandled),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
      user: action.user,
      showSnackbar: true,
      isLoading: false,
      isError: false,
      errorMessage: null,
      successMessage: "Bienvenue, " + action.user.firstName);
}

UserState _loginFailed(UserState state, LoginFailedAction action) {
  return state.copyWith(
      user: null,
      showSnackbar: true,
      isLoading: false,
      isError: true,
      errorMessage: action.errorMessage,
      successMessage: null);
}

UserState _startLoading(UserState state, StartLoadingAction action) {
  return state.copyWith(
      user: null,
      showSnackbar: false,
      isLoading: true,
      isError: false,
      errorMessage: null,
      successMessage: null);
}

UserState _markSnackbarHasHandled(
    UserState state, MarkSnackbarHasHandledAction action) {
  return state.copyWith(
      showSnackbar: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      successMessage: null);
}
