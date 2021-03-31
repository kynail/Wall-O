import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text("Ceci est la page Accueil",
                    style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
