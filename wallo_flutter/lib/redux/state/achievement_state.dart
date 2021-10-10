import 'package:wallo_flutter/models/new_achievement.dart';

class AchievementState {
  AchievementState({
    this.newAchievement,
  });

  final NewAchievement newAchievement;

  factory AchievementState.initial() => AchievementState(
        newAchievement: NewAchievement.empty(),
      );

  AchievementState copyWith({
    NewAchievement newAchievement,
  }) {
    return AchievementState(
      newAchievement: newAchievement ?? this.newAchievement,
    );
  }

  @override
  String toString() => 'AchievementState(newAchievement: $newAchievement)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AchievementState && other.newAchievement == newAchievement;
  }

  @override
  int get hashCode => newAchievement.hashCode;
}
