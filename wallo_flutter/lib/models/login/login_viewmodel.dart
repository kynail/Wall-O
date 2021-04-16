import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';

import '../user.dart';

class LoginViewModel {
  final bool isLoading;
  final bool isError;
  final String successMessage;
  final String errorMessage;
  final User user;

  final Function(String, String) login;

  LoginViewModel({
    this.successMessage,
    this.errorMessage,
    this.isLoading,
    this.isError,
    this.user,
    this.login,
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      isLoading: store.state.userState.isLoading,
      isError: store.state.userState.isError,
      user: store.state.userState.user,
      errorMessage: store.state.userState.errorMessage,
      successMessage: store.state.userState.successMessage,
      login: (String username, String password) {
        store.dispatch(logUser(username, password));
      },
    );
  }
}
