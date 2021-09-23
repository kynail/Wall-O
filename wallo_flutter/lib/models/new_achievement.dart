import 'dart:convert';

import 'package:wallo_flutter/models/achievement.dart';

class NewAchievement {
  NewAchievement({
    this.achievement,
    this.message,
  });

  final Achievement achievement;
  final String message;

  factory NewAchievement.empty() {
    return NewAchievement(
      achievement: Achievement.empty(),
      message: "",
    );
  }

  NewAchievement copyWith({
    Achievement achievement,
    String message,
  }) {
    return NewAchievement(
      achievement: achievement ?? this.achievement,
      message: message ?? this.message,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory NewAchievement.fromJson(String source) =>
      NewAchievement.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewAchievement(achievement: $achievement, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewAchievement &&
        other.achievement == achievement &&
        other.message == message;
  }

  @override
  int get hashCode => achievement.hashCode ^ message.hashCode;
}
