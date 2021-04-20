import 'package:redux/redux.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

import '../user.dart';

class ProfileViewModel {
  final MessengerState messenger;
  final User user;
  final Function(double exp) addExp;

  ProfileViewModel({this.messenger, this.user, this.addExp});

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
        messenger: store.state.messengerState,
        user: store.state.userState.user,
        addExp: (exp) =>
            store.dispatch(setExp(store.state.userState.user, exp)));
  }
}