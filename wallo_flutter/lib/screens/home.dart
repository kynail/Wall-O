import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accueil"),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: Center(
            child: Text("Ceci est la page Accueil",
                style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
