import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';

class ForgetPasswordViewModel {
  final bool isLoading;
  final Function(String mail) onSendForget;

  ForgetPasswordViewModel({
    this.isLoading,
    this.onSendForget,
  });

  static ForgetPasswordViewModel fromStore(Store<AppState> store) {
    return ForgetPasswordViewModel(
      isLoading: store.state.messengerState.isLoading,
      onSendForget: (String mail) => store.dispatch(sendForget(mail)),
    );
  }
}
