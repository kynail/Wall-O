import 'package:meta/meta.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class GameState {
  final List<User> leaderboard;

  GameState({
    @required this.leaderboard,
  });

  factory GameState.initial() => new GameState(leaderboard: null);

  GameState copyWith({List<User> leaderboard}) {
    return GameState(leaderboard: leaderboard ?? this.leaderboard);
  }

  @override
  String toString() {
    return 'GameState: {leaderboard = $leaderboard}';
  }
}
