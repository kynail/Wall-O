import 'package:meta/meta.dart';
import 'package:wallo_flutter/redux/state/game_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';
import 'package:wallo_flutter/redux/state/user_state.dart';

@immutable
class AppState {
  final MessengerState messengerState;
  final UserState userState;
  final GameState gameState;

  AppState(
      {@required this.userState,
      @required this.messengerState,
      @required this.gameState});

  factory AppState.initial() {
    return AppState(
        messengerState: MessengerState.initial(),
        userState: UserState.initial(),
        gameState: GameState.initial());
  }

  AppState copyWith({
    MessengerState messengerState,
    UserState userState,
  }) {
    return AppState(
        messengerState: messengerState ?? this.messengerState,
        userState: userState ?? this.userState,
        gameState: gameState ?? this.gameState);
  }

  @override
  int get hashCode =>
      //isLoading.hash Code ^
      userState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          userState == other.userState &&
          gameState == other.gameState;
}
