import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

class ResetPasswordViewModel {
  final MessengerState messenger;
  final Function(String, String, String) resetPassword;

  ResetPasswordViewModel({
    this.messenger,
    this.resetPassword,
  });

  static ResetPasswordViewModel fromStore(Store<AppState> store) {
    return ResetPasswordViewModel(
      messenger: store.state.messengerState,
      resetPassword: (String password, String confirmPassword, String token) =>
          store.dispatch(resetPassord(password, confirmPassword, token)),
    );
  }
}
