import 'dart:convert';
import 'package:wallo_flutter/models/server_message.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:wallo_flutter/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<User> login(String mail, String password) async {
  if (mail.isEmpty || password.isEmpty) {
    Error error = new Error();
    return Future.error(error);
  } else {
    try {
      final response = await http.post(
          Uri.parse(env["API_URL"] + "/users/login"),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'mail': mail, 'password': password});

      ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));

      if (res.success == true) {
        return User.fromJson(res.data);
      } else {
        return Future.error(getServerMessage(response, true));
      }
    } on Exception {
      return Future.error("Connexion au serveur impossible");
    }
  }
}

Future<User> register(
    String name, String firstName, String mail, String passw) async {
  if (name.isEmpty || firstName.isEmpty || mail.isEmpty || passw.isEmpty) {
    Error error = new Error();

    return Future.error(error);
  } else {
    try {
      final response = await http
          .post(Uri.parse(env["API_URL"] + "/users/register"), headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }, body: {
        'mail': mail,
        'password': passw,
        "lastName": name,
        "firstName": firstName
      });

      ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));
      print("REGISTER RES $res");

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

Future<User> googleRequest(String requestUrl) async {
  try {
    print("REQUEST URL $requestUrl");
    final response = await http.get(Uri.parse(requestUrl));
    print("RESPONSE === ${response.body}");

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));
    print("WUT === $res");

    if (res.success == true) {
      return User.fromJson(res.data);
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}
