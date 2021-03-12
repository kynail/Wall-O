import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profil"), iconTheme: IconThemeData(color: Colors.white)),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text("Ceci est la page Profil",
                  style: TextStyle(fontSize: 20))),
          StoreConnector<AppState, User>(
            distinct: true,
            converter: (store) => store.state.userState.user,
            builder: (context, user) {
              return new Text(
                user.firstName,
              );
            },
          )
        ],
      ),
    );
  }
}
