import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'new_achievement.dart';

class UnlockedFish {
  UnlockedFish({
    this.aquadex,
    this.newAchievement,
  });

  final List<String> aquadex;
  final NewAchievement newAchievement;

  UnlockedFish copyWith({
    List<String> aquadex,
    NewAchievement newAchievement,
  }) {
    return UnlockedFish(
      aquadex: aquadex ?? this.aquadex,
      newAchievement: newAchievement ?? this.newAchievement,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'aquadex': aquadex,
    };
  }

  factory UnlockedFish.fromMap(Map<String, dynamic> map) {
    return UnlockedFish(
      aquadex: List<String>.from(map['aquadex']),
      newAchievement: map["newAchievement"] != null
          ? NewAchievement.fromMap(map["newAchievement"])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnlockedFish.fromJson(String source) =>
      UnlockedFish.fromMap(json.decode(source));

  @override
  String toString() => 'UnlockedFish(aquadex: $aquadex)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnlockedFish && listEquals(other.aquadex, aquadex);
  }

  @override
  int get hashCode => aquadex.hashCode;
}
