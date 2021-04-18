import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/customAppbar.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/wallo.png"),
              width: 200,
              height: 120,
            ),
            Text(
              "Bienvenue",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ],
        ),
      ),
      body: Text("SIGN IN SCREEN"),
    );
  }
}
