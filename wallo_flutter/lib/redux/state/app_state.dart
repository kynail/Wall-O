import 'package:meta/meta.dart';

import 'package:wallo_flutter/models/Fish.dart';
import 'package:wallo_flutter/redux/state/game_state.dart';
import 'package:wallo_flutter/redux/state/messenger_state.dart';
import 'package:wallo_flutter/redux/state/user_state.dart';

import 'fish_state.dart';

@immutable
class AppState {
  final MessengerState messengerState;
  final UserState userState;
  final GameState gameState;
  final FishState fishState;

  AppState({
    @required this.userState,
    @required this.messengerState,
    @required this.gameState,
    @required this.fishState,
  });

  factory AppState.initial() {
    return AppState(
        messengerState: MessengerState.initial(),
        userState: UserState.initial(),
        gameState: GameState.initial(),
        fishState: FishState.initial());
  }

  AppState copyWith({
    MessengerState messengerState,
    UserState userState,
    GameState gameState,
    FishState fishState,
  }) {
    return AppState(
      messengerState: messengerState ?? this.messengerState,
      userState: userState ?? this.userState,
      gameState: gameState ?? this.gameState,
      fishState: fishState ?? this.fishState,
    );
  }

  @override
  int get hashCode {
    return messengerState.hashCode ^
        userState.hashCode ^
        gameState.hashCode ^
        fishState.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.messengerState == messengerState &&
        other.userState == userState &&
        other.gameState == gameState &&
        other.fishState == fishState;
  }
}
