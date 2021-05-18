import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallo_flutter/models/Fish.dart';
import 'package:http/http.dart' as http;
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/models/server_message.dart';
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
      'image': await MultipartFile.fromFile(imagePath, filename: 'coucou.jpg')
    });

    print("IN ANALYZE FISH $aquadex");

    final response =
        await dio.post('http://165.169.231.252:8000/upload', data: formData);
    final fishesResponse = response.data["img"];

    if (fishesResponse == "") {
      return [];
    }

    List<String> fishesData = fishesResponse.split(",");

    List<AquadexFish> fishes = [];

    print("fishes DATA ${fishesData.length}");

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
      print("NULLL");
      return [];
    }

    return fishes;
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
