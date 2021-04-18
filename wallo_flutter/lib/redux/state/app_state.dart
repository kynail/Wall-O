import 'package:meta/meta.dart';
import 'package:wallo_flutter/redux/state/messenger/messenger_state.dart';
import 'package:wallo_flutter/redux/state/user/user_state.dart';

@immutable
class AppState {
  final MessengerState messengerState;
  final UserState userState;

  AppState({@required this.userState, @required this.messengerState});

  factory AppState.initial() {
    return AppState(
      messengerState: MessengerState.initial(),
      userState: UserState.initial(),
    );
  }

  AppState copyWith({
    MessengerState messengerState,
    UserState userState,
  }) {
    return AppState(
      messengerState: messengerState ?? this.messengerState,
      userState: userState ?? this.userState,
    );
  }

  @override
  int get hashCode =>
      //isLoading.hash Code ^
      userState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && userState == other.userState;
}
