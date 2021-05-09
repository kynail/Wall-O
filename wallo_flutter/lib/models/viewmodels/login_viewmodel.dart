import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

class LoginViewModel {
  final MessengerState messenger;
  final Function(String, String) login;
  final Function(String name, String firstname, String mail, String passw)
      register;
  final Function(String) logWithGoogle;
  final Function() getCameras;

  LoginViewModel(
      {this.messenger,
      this.login,
      this.register,
      this.logWithGoogle,
      this.getCameras});

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
        messenger: store.state.messengerState,
        login: (String username, String password) {
          store.dispatch(logUser(username, password));
        },
        getCameras: () => store.dispatch(getCamerasAction()),
        register: (name, firstname, mail, passw) =>
            store.dispatch(registerUser(name, firstname, mail, passw)),
        logWithGoogle: (requestUrl) => store.dispatch(googleLogin(requestUrl)));
  }
}
