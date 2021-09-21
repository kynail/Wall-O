import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/models/level.dart';

@immutable
class User {
  User({
    this.lastName = "",
    this.firstName = "",
    this.mail = "",
    this.id = "",
    this.avatar,
    this.level,
    this.aquadex,
  });

  final String lastName;
  final String firstName;
  final String mail;
  final String id;
  final Avatar avatar;
  final Level level;
  final List<String> aquadex;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      lastName: json['lastName'],
      firstName: json['firstName'],
      mail: json['mail'],
      id: json['id'],
      aquadex: List.from(json['aquadex']),
      avatar: Avatar.fromJson(json['avatar']),
      level: Level.fromJson(json['game']),
    );
  }

  bool isValid() {
    return lastName != null &&
        firstName != null &&
        mail != null &&
        avatar != null &&
        level != null &&
        aquadex != null;
  }

  // User.setAvatar(Avatar avatar) {
  //   this.copyWith(avatar: avatar);
  // }

  @override
  String toString() {
    return 'User: {user: $lastName, firstName: $firstName, mail: $mail, id: $id, avatar: $avatar, level: $level, aquadex: $aquadex}';
  }

  User copyWith({
    String lastName,
    String firstName,
    String mail,
    String id,
    Avatar avatar,
    Level level,
    List<String> aquadex,
  }) {
    return User(
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      mail: mail ?? this.mail,
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      level: level ?? this.level,
      aquadex: aquadex ?? this.aquadex,
    );
  }
}
