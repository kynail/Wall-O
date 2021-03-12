import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/store.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  void handleLogin(BuildContext context) {
    Redux.store.dispatch(logUser);
    //Navigator.pushReplacementNamed(context, "/home");
  }

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
                handleLogin(context);
              },
              child: Text("Accueil",
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ]),
      ),
    );
  }
}
