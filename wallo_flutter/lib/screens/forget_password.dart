import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _mail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Mot de passe oublié"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Saisissez l'adresse électronique utilisée lors de votre inscription et nous vous enverrons des instructions pour réinitialiser votre mot de passe.",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
                "Pour des raisons de sécurité, nous ne stockons PAS votre mot de passe. Soyez donc assuré que nous ne vous enverrons jamais votre mot de passe par courrier électronique.",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 40),
            Text("Adresse email"),
            SizedBox(height: 10),
            TextField(
                onChanged: (value) {
                  setState(() {
                    _mail = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Entrez une adresse e-mail',
                  border: InputBorder.none,
                  fillColor: Color(0xfffff6d4),
                  filled: true,
                )),
            SizedBox(height: 20),
            Center(
                child: Container(
              child: ElevatedButton(
                  onPressed: () {
                    Redux.store.dispatch((store) => sendForget(store, _mail));
                  },
                  child: Row(
                    children: [
                      CircularProgressIndicator(
                          value: null, valueColor: AnimationF),
                      Text(
                        "Envoyer les instructions de réinitialisation",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            )),
          ],
        ),
      ),
    );
  }
}