import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:wallo_flutter/models/achievement.dart';
import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/redux/actions/messenger_actions.dart';
import 'package:wallo_flutter/redux/actions/user_action.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';

import '../user.dart';

class ProfileViewModel {
  final MessengerState messenger;
  final User user;
  final List<Achievement> achievements;
  final Function(double exp) addExp;
  final Function(String seed, String type) onSaveAvatarPressed;
  final Function() playConfetti;
  final Function(BuildContext context) onDisconnect;

  ProfileViewModel({
    this.messenger,
    this.user,
    this.addExp,
    this.onSaveAvatarPressed,
    this.playConfetti,
    this.achievements,
    this.onDisconnect,
  });

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
      messenger: store.state.messengerState,
      user: store.state.userState.user,
      achievements: store.state.gameState.achievements,
      addExp: (exp) => store.dispatch(
        setExp(store.state.userState.user, exp),
      ),
      onSaveAvatarPressed: (seed, dropDownValue) => store.dispatch(
        setAvatar(
          Avatar(seed: seed, type: dropDownValue),
          store.state.userState.user,
        ),
      ),
      playConfetti: () async {
        store.dispatch(new PlayConfettiAction());
        await Future.delayed(const Duration(seconds: 2), () {
          print("WUUUUT STOP");
          store.dispatch(new StopConfettiAction());
        });
      },
      onDisconnect: (context) {
        store.dispatch(new StopLoadingAction());
        Navigator.of(context).pushReplacementNamed("/");
        print("DISCONNECT FROM REDUX");
      },
    );
  }
}
