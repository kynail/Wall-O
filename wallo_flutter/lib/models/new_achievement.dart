import 'dart:convert';

import 'package:wallo_flutter/models/achievement.dart';
import 'package:wallo_flutter/models/level.dart';

Map<String, dynamic> _achievementMapToLevel(Map<String, dynamic> game) {
  return {
    "xpscore": game["data"]["xpscore"],
    "nxtlvl": game["data"]["nxtlvl"],
    "userlvl": game["data"]["userlvl"],
    "totalxp": game["data"]["totalxp"],
    "achievements": game["achievements"],
  };
}

class NewAchievement {
  NewAchievement({
    this.achievement,
    this.message,
    this.game,
  });

  final Achievement achievement;
  final String message;
  final Level game;

  factory NewAchievement.empty() {
    return NewAchievement(
      achievement: Achievement.empty(),
      message: "",
      game: null,
    );
  }

  NewAchievement copyWith({
    Achievement achievement,
    String message,
    Level game,
  }) {
    return NewAchievement(
      achievement: achievement ?? this.achievement,
      message: message ?? this.message,
      game: game ?? this.game,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'achievement': achievement.toMap(),
      'message': message,
    };
  }

  factory NewAchievement.fromMap(Map<String, dynamic> map) {
    return NewAchievement(
      achievement: Achievement.fromMap(map['achievement']),
      message: map['game']["message"],
      game: Level.fromJson(_achievementMapToLevel(map['game'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewAchievement.fromJson(String source) =>
      NewAchievement.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewAchievement(achievement: $achievement, message: $message, game: $game)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewAchievement &&
        other.achievement == achievement &&
        other.message == message &&
        other.game == game;
  }

  @override
  int get hashCode => achievement.hashCode ^ message.hashCode ^ game.hashCode;
}
