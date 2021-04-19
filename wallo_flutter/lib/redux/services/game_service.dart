import 'dart:convert';
import 'package:wallo_flutter/models/server_message.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../utils.dart';

Future<List<User>> leaderboardRequest() async {
  try {
    final response = await http.get(Uri.parse(env["API_URL"] + "/game/rank"));

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));

    if (res.success == true) {
      List<User> leaderboard = [];

      res.data.forEach((user) {
        leaderboard.add(User.fromJson(user));
      });
      return leaderboard;
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}
