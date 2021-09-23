import 'package:meta/meta.dart';

import 'package:wallo_flutter/models/achievement.dart';
import 'package:wallo_flutter/models/user.dart';

@immutable
class GameState {
  final List<User> leaderboard;
  final List<Achievement> achievements;

  GameState({
    @required this.leaderboard,
    @required this.achievements,
  });

  factory GameState.initial() => new GameState(
        leaderboard: null,
        achievements: null,
      );

  GameState copyWith({
    List<User> leaderboard,
    List<Achievement> achievements,
  }) {
    return GameState(
      leaderboard: leaderboard ?? this.leaderboard,
      achievements: achievements ?? this.achievements,
    );
  }

  @override
  String toString() =>
      'GameState(leaderboard: $leaderboard, achievements: $achievements)';
}
