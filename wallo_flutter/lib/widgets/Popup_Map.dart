import 'package:flutter/material.dart';
import 'mapé.dart';



class PopupMap extends StatelessWidget {
  const PopupMap({Key key, @required this.latitude, @required this.longitude, @required this.zoom}) : super(key: key);
  final double latitude;
  final double longitude;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localisation'),
      ),
      body:  ShowMap(latitude: latitude, longitude: longitude,),
    );

    // return new AlertDialog(
    // title: const Text('Poisson Capturé à :'),
    // content: ShowMap(),
    // );
  }
}