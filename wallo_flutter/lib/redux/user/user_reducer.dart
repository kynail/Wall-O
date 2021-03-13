import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

userReducer(UserState prevState, SetUserStateAction action) {
  final payload = action.userState;

  return prevState.copyWith(
    isError: payload.isError,
    errorMessage: payload.errorMessage,
    isLoading: payload.isLoading,
    user: payload.user,
  );
}
