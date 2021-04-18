import 'dart:convert';

import 'package:wallo_flutter/models/server_message.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:wallo_flutter/utils.dart';

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

      ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));
      print("RESPONSE");
      print(res);

      if (res.success == true) {
        return User.fromJson(jsonDecode(response.body)["data"]);
      } else {
        return Future.error(getServerMessage(response, true));
      }
    } on Exception {
      return Future.error("Connexion au serveur impossible");
    }
  }
}
