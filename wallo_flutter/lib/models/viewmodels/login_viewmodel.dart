import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/messenger/messenger_actions.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/actions/login_actions.dart';
import 'package:wallo_flutter/redux/state/messenger/messenger_state.dart';

class LoginViewModel {
  final MessengerState messenger;
  final Function(String, String) login;
  final Function() markSnackbarHandled;

  LoginViewModel({this.messenger, this.login, this.markSnackbarHandled});

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
        messenger: store.state.messengerState,
        login: (String username, String password) {
          store.dispatch(logUser(username, password));
        },
        markSnackbarHandled: () {
          store.dispatch(new MarkSnackbarHasHandledAction());
        });
  }
}
