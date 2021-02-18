import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profil"), iconTheme: IconThemeData(color: Colors.white)),
      drawer: CustomDrawer(),
      body: Container(
        child: Center(
            child: Text("Ceci est la page Profil",
                style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
