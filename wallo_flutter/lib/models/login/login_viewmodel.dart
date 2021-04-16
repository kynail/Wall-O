import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';

import '../user.dart';

class LoginViewModel {
  final bool isLoading;
  final bool isError;
  final User user;

  final Function(String, String) login;

  LoginViewModel({
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
      login: (String username, String password) {
        store.dispatch(logUser(username, password));
      },
    );
  }
}
