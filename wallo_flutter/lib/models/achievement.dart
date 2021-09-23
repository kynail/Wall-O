import 'dart:convert';

class Achievement {
  Achievement({
    this.id,
    this.imageUrl,
    this.uniqueName,
    this.title,
    this.description,
    this.xp,
  });

  final String id;
  final String imageUrl;
  final String uniqueName;
  final String title;
  final String description;
  final int xp;

  factory Achievement.empty() {
    return Achievement(
      id: "",
      imageUrl: "",
      uniqueName: "",
      title: "",
      description: "",
      xp: 0,
    );
  }

  Achievement copyWith({
    String id,
    String imageUrl,
    String uniqueName,
    String title,
    String description,
    int xp,
  }) {
    return Achievement(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      uniqueName: uniqueName ?? this.uniqueName,
      title: title ?? this.title,
      description: description ?? this.description,
      xp: xp ?? this.xp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      'imageUrl': imageUrl,
      'uniqueName': uniqueName,
      'title': title,
      'description': description,
      'xp': xp,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map["_id"],
      imageUrl: map['imageUrl'],
      uniqueName: map['uniqueName'],
      title: map['title'],
      description: map['description'],
      xp: map['xp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Achievement.fromJson(String source) =>
      Achievement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Achievement(id: $id, imageUrl: $imageUrl, uniqueName: $uniqueName, title: $title, description: $description, xp: $xp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Achievement &&
        other.id == id &&
        other.imageUrl == imageUrl &&
        other.uniqueName == uniqueName &&
        other.title == title &&
        other.description == description &&
        other.xp == xp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        uniqueName.hashCode ^
        title.hashCode ^
        description.hashCode ^
        xp.hashCode;
  }
}
