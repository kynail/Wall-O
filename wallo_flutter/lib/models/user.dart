import 'dart:convert';

import 'package:wallo_flutter/models/avatar.dart';

class User {
  User(
      {this.lastName = "",
      this.firstName = "",
      this.mail = "",
      this.id = "",
      this.avatar});

  String lastName;
  String firstName;
  String mail;
  String id;
  Avatar avatar;

  factory User.fromJson(Map<String, dynamic> json) {
    print("JSON");
    print(json);
    return User(
        lastName: json['lastName'],
        firstName: json['firstName'],
        mail: json['mail'],
        id: json['id'],
        avatar: Avatar.fromJson(json['avatar']));
  }

  User.setAvatar(Avatar avatar) {
    this.avatar = avatar;
  }

  @override
  String toString() {
    return 'User: {user: $lastName, firstName: $firstName, mail: $mail, id: $id, avatar: $avatar}';
  }
}
