import 'package:flutter/material.dart';
import 'mapé.dart';



class PopupMap extends StatelessWidget {
  const PopupMap({Key key, @required this.latitude, @required this.longitude}) : super(key: key);
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ShowMap(latitude: latitude, longitude: longitude,),
      ),
    );

    // return new AlertDialog(
    // title: const Text('Poisson Capturé à :'),
    // content: ShowMap(),
    // );
  }
}