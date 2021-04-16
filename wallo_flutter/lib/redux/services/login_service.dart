import 'dart:convert';

import 'package:wallo_flutter/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> login(String mail, String password) async {
  if (mail.isEmpty || password.isEmpty) {
    Error error = new Error();
    return Future.error(error);
  } else {
    try {
      final response = await http.post(
          Uri.http("localhost:8080", "users/login"),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'mail': mail, 'password': password});

      print("RESPONSE");
      print(response);

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body)["data"]);
      } else {
        return Future.error("Connexion au serveur impossible");
      }
    } on Exception {
      return Future.error("Connexion au serveur impossible");
    }
  }
}
