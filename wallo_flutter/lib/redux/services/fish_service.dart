import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallo_flutter/models/Fish.dart';
import 'package:wallo_flutter/models/server_message.dart';
import 'package:wallo_flutter/route_generator.dart';

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

Future<List<Fish>> analyseFishRequest(String imagePath) async {
  var dio = Dio();
  try {
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath, filename: 'coucou.jpg')
    });

    final response =
        await dio.post('http://192.168.1.10:8000/upload', data: formData);
    final fishesResponse = response.data["img"];

    print("FISHES RESPONSE $fishesResponse");

    if (fishesResponse == "") {
      return [];
    }

    List<String> fishesData = fishesResponse.split(",");

    List<Fish> fishes = [];

    print("fishes DATA ${fishesData.length}");

    if (fishesData.isNotEmpty == true) {
      fishesData.forEach((fishData) {
        fishes.add(new Fish.fromString(fishData));
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
