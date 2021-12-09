import 'dart:convert';
import 'dart:developer';
import 'package:wallo_flutter/models/achievement.dart';
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

Future<List<Achievement>> getAchievementRequest() async {
  try {
    final response =
        await http.get(Uri.parse(env["API_URL"] + "/achievements"));
    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));

    if (res.success == true) {
      List<Achievement> achievements = [];

      res.data.forEach((achievement) {
        achievements.add(Achievement.fromMap(achievement));
      });
      return achievements;
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}

Future<int> incFishCountRequest(String userId) async {
  try {
    print("DEDJEDHQZJDQZHJDQHJDHZKJHJQZHDJZDHKJQDHKDH");
    final response = await http.put(
      Uri.parse(env["API_URL"] + "/game/incFishCount"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'id': userId},
    );
    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));
    log(res.toString());
    if (res.success == true) {
      return res.data;
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}
