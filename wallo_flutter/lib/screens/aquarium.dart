import 'package:flutter/material.dart';

class Aquarium extends StatelessWidget {
  const Aquarium({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Aquarium"),
          iconTheme: IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: SizedBox.expand(
            child: Stack(
          children: [
            Text("Bonjour"),
          ],
        )),
      ),
    );
  }
}
