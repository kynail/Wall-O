import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

class Classement extends StatelessWidget {
  const Classement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Classement"),
          iconTheme: IconThemeData(color: Colors.white)),
      drawer: CustomDrawer(),
      body: Container(
        child: Center(
            child: Text("Ceci est la page Classement",
                style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
