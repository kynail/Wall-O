import 'package:flutter/material.dart';
import 'mapé.dart';



class PopupMap extends StatelessWidget {
  const PopupMap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
    title: const Text('Poisson Capturé à :'),
    content: ShowMap(),
    );
  }
}