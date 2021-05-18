import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:wallo_flutter/models/Fish.dart';

class AquadexFish {
  String name;
  String scientificName;
  String image;
  String slug;
  String desc;
  Fish fish;

  AquadexFish({
    @required this.name,
    @required this.scientificName,
    @required this.image,
    @required this.desc,
    @required this.slug,
    this.fish,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AquadexFish &&
        other.name == name &&
        other.scientificName == scientificName &&
        other.image == image &&
        other.slug == slug &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        scientificName.hashCode ^
        image.hashCode ^
        slug.hashCode ^
        desc.hashCode;
  }

  @override
  String toString() {
    return 'AquadexFish(name: $name, scientificName: $scientificName, image: $image, slug: $slug, desc: $desc, fish: $fish)';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'scientificName': scientificName,
      'image': image,
      'desc': desc,
      'slug': slug
    };
  }

  factory AquadexFish.fromMap(Map<String, dynamic> map) {
    return AquadexFish(
        name: map['name'],
        scientificName: map['scientificName'],
        image: map['image'],
        desc: map['desc'],
        slug: map['slug']);
  }

  String toJson() => json.encode(toMap());

  factory AquadexFish.fromJson(String source) =>
      AquadexFish.fromMap(json.decode(source));

  AquadexFish copyWith({
    String name,
    String scientificName,
    String image,
    String slug,
    String desc,
    Fish fish,
  }) {
    return AquadexFish(
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      image: image ?? this.image,
      slug: slug ?? this.slug,
      desc: desc ?? this.desc,
      fish: fish ?? this.fish,
    );
  }
}
