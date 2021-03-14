import 'dart:convert';

class User {
  User({this.lastName = "", this.firstName = "", this.mail = ""});

  String lastName;
  String firstName;
  String mail;

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
        lastName: json['lastName'],
        firstName: json['firstName'],
        mail: json['mail']);
  }

  User.setName(String name) {
    // this.name = name;
  }

  @override
  String toString() {
    return 'User: {user: $lastName, firstName: $firstName, mail: $mail}';
  }
}
