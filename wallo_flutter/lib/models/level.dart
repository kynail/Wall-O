class Level {
  Level({this.level, this.nextLvl, this.xp, this.totalXp, this.achievements});

  int xp;
  int nextLvl;
  int level;
  int totalXp;
  List<String> achievements;

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      xp: json['xpscore'] as int,
      nextLvl: json['nxtlvl'] as int,
      level: json['userlvl'] as int,
      totalXp: json['totalxp'] as int,
      achievements: List.from(json['achievements']),
    );
  }

  @override
  String toString() {
    return 'Level: {xp: ${xp.toString()}, nextLevel: ${nextLvl.toString()}, level: ${level.toString()}}';
  }
}
