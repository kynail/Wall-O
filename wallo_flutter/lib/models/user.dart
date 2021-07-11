import 'dart:convert';

import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/models/level.dart';

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

  String lastName;
  String firstName;
  String mail;
  String id;
  Avatar avatar;
  Level level;
  List<String> aquadex;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        lastName: json['lastName'],
        firstName: json['firstName'],
        mail: json['mail'],
        id: json['id'],
        aquadex: List.from(json['aquadex']),
        avatar: Avatar.fromJson(json['avatar']),
        level: Level.fromJson(json['game']));
  }

  User.setAvatar(Avatar avatar) {
    this.avatar = avatar;
  }

  @override
  String toString() {
    return 'User: {user: $lastName, firstName: $firstName, mail: $mail, id: $id, avatar: $avatar, level: $level, aquadex: $aquadex}';
  }
}
