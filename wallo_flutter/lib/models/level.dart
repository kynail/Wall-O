import 'dart:convert';

class Level {
  Level({this.level, this.nextLvl, this.xp});

  int xp;
  int nextLvl;
  int level;

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
        xp: json['xpscore'] as int,
        nextLvl: json['nxtlvl'] as int,
        level: json['userlvl'] as int);
  }

  @override
  String toString() {
    return 'Level: {xp: ${xp.toString()}, nextLevel: ${nextLvl.toString()}, level: ${level.toString()}}';
  }
}
