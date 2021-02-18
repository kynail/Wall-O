import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription"),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Ceci est la page Inscription", style: TextStyle(fontSize: 20)),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/login");
              },
              child: Text("Page connexion",
                  style: TextStyle(fontSize: 20, color: Colors.white))),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: Text("Accueil",
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ]),
      ),
    );
  }
}
