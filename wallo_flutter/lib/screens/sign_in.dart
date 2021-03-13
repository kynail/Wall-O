import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/store.dart';
// import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:wallo_flutter/widgets/handle_error.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void handleLogin(BuildContext context, bool isError) {
    Redux.store.dispatch(logUser);

    if (isError == false) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        distinct: true,
        converter: (store) => store.state.userState,
        onWillChange: (state, userState) {
          handleError(context, userState);
        },
        builder: (context, userState) {
          print("IN SIGN IN");
          print(userState);
          return Scaffold(
            appBar: AppBar(
              title: Text("Inscription"),
            ),
            body: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("Ceci est la page Inscription",
                    style: TextStyle(fontSize: 20)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/login");
                    },
                    child: Text("Page connexion",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
                ElevatedButton(
                    onPressed: () {
                      handleLogin(context, userState.isError);
                    },
                    child: Text("Accueil",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              ]),
            ),
          );
        });
  }
}
