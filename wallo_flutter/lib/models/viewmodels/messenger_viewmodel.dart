import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

class MessengerViewModel {
  final MessengerState messenger;
  final Function() markSnackbarHandled;

  MessengerViewModel({this.messenger, this.markSnackbarHandled});

  static MessengerViewModel fromStore(Store<AppState> store) {
    return MessengerViewModel(
        messenger: store.state.messengerState,
        markSnackbarHandled: () {
          store.dispatch(new MarkSnackbarHasHandledAction());
        });
  }
}
