import 'dart:convert';
import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/models/level.dart';
import 'package:wallo_flutter/models/server_message.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils.dart';

Future<List> expRequest(User user, double exp) async {
  try {
    final response = await http.put(Uri.parse(env["API_URL"] + "/game/level"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'id': user.id, 'exp': exp.toStringAsFixed(0)});

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));

    if (res.success == true) {
      return [Level.fromJson(res.data), res.message];
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}

Future<User> setAvatarRequest(Avatar avatar, User user) async {
  try {
    final response = await http.put(
      Uri.parse(env["API_URL"] + "/game/avatar"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'id': user.id, "type": avatar.type, "seed": avatar.seed},
    );

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));

    if (res.success == true) {
      return user.copyWith(avatar: avatar);
    } else {
      return Future.error("Une erreur s'est produite, veuillez réessayer");
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}

Future<String> sendForgetRequest(String mail) async {
  try {
    final response = await http.post(
      Uri.http("localhost:8080", "/users/auth/forget"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'mail': mail},
    );

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));

    if (res.success == true) {
      return res.message;
    } else {
      return Future.error(res.message);
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}
