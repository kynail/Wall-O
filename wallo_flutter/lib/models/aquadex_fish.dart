import 'dart:convert';

import 'package:flutter/material.dart';

class AquadexFish {
  String name;
  String scientificName;
  String image;
  String desc;

  AquadexFish({
    @required this.name,
    @required this.scientificName,
    @required this.image,
    @required this.desc,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AquadexFish &&
        other.name == name &&
        other.scientificName == scientificName &&
        other.image == image &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        scientificName.hashCode ^
        image.hashCode ^
        desc.hashCode;
  }

  @override
  String toString() {
    return 'AquadexFish(name: $name, scientificName: $scientificName, image: $image, desc: $desc)';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'scientificName': scientificName,
      'image': image,
      'desc': desc,
    };
  }

  factory AquadexFish.fromMap(Map<String, dynamic> map) {
    return AquadexFish(
      name: map['name'],
      scientificName: map['scientificName'],
      image: map['image'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AquadexFish.fromJson(String source) =>
      AquadexFish.fromMap(json.decode(source));
}
