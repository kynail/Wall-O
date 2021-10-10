import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallo_flutter/models/Fish.dart';
import 'package:http/http.dart' as http;
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/models/server_message.dart';
import 'package:wallo_flutter/models/unlocked_fish.dart';
import 'dart:convert';

import '../../utils.dart';

// Future<List<Fish>> analyseFishRequest(String imagePath, bool error) async {
//   try {
//     await Future.delayed(const Duration(seconds: 1));

//     if (error) {
//       return Future.error("Connexion au serveur impossible");
//     }
//     String res = "";

//     List<String> fishesData = res.split(",");

//     List<Fish> fishes = [];

//     if (fishes.length > 0) {
//       fishesData.forEach((fishData) {
//         fishes.add(new Fish.fromString(fishData));
//       });
//     } else {
//       return [];
//     }

//     return fishes;
//   } on Exception {
//     return Future.error("Connexion au serveur impossible");
//   }
// }

Future<List<AquadexFish>> analyseFishRequest(
    String imagePath, List<AquadexFish> aquadex) async {
  var dio = Dio();
  try {
    var formData = FormData.fromMap({
      'images': await MultipartFile.fromFile(imagePath, filename: 'coucou.jpg')
    });

    final rawResponse =
        await dio.post('http://50.17.147.88/analyse', data: formData);
    print("rawResponse ${rawResponse.data}");
    final response = jsonDecode(rawResponse.toString());
    print("RESPONSE $response");
    final fishesResponse = response["fishes"];

    print("fishesReponse $fishesResponse");

    if (fishesResponse == "") {
      return [];
    }

    List<String> fishesData = fishesResponse.split(",");

    List<AquadexFish> fishes = [];

    if (fishesData.isNotEmpty == true) {
      fishesData.forEach((fishData) {
        final Fish fish = Fish.fromString(fishData);
        aquadex.forEach((aquadexFish) {
          if (aquadexFish.slug == fish.name) {
            fishes.add(
              aquadexFish.copyWith(
                fish: fish,
              ),
            );
          }
        });
        //   fishes.add(new Fish.fromString(fishData));
      });
    } else {
      return [];
    }

    print("last one $fishes");

    return fishes;
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}

Future<UnlockedFish> getUnlockedFishRequest(
    String fishId, String userId) async {
  try {
    final response = await http.post(
      Uri.parse(env["API_URL"] + "/users/aquadex/add"),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'id': userId, 'fishId': fishId},
    );

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));
    if (res.success == true) {
      return UnlockedFish.fromMap(res.data);
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}

Future<List<AquadexFish>> getAquadexRequest() async {
  try {
    final response = await http.get(Uri.parse(env["API_URL"] + "/fishes/all"));

    ServerMessage res = new ServerMessage.fromJson(jsonDecode(response.body));
    if (res.success == true) {
      List<AquadexFish> aquadex = [];

      res.data.forEach((fish) {
        aquadex.add(AquadexFish.fromMap(fish));
      });
      return aquadex;
    } else {
      return Future.error(getServerMessage(response, true));
    }
  } on Exception {
    return Future.error("Connexion au serveur impossible");
  }
}
