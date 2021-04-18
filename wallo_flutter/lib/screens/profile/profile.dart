import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/state/user/user_state.dart';
import 'package:wallo_flutter/screens/profile/profile_main_info.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/widgets/handle_snackbar.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        distinct: true,
        converter: (store) => store.state.userState,
        onWillChange: (state, userState) {
          // handleError(context, userState);
        },
        builder: (context, userState) {
          return Scaffold(
            appBar: AppBar(
                title: Text("Mon Profil"),
                iconTheme: IconThemeData(color: Colors.white)),
            drawer: CustomDrawer(),
            backgroundColor: AppTheme.secondaryColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileMainInfo(user: userState.user),
                    SizedBox(height: 12),
                    ProfileFishInfo(),
                    SizedBox(height: 60),
                    Divider(thickness: 2),
                    AddExp(user: userState.user)
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class ProfileFishInfo extends StatelessWidget {
  const ProfileFishInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text("26",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: AppTheme.primaryColor)),
            Text(
              "Nombre de poissons trouvés",
              style: TextStyle(color: AppTheme.secondaryText),
            ),
          ],
        ),
        Column(
          children: [
            Text("5",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: AppTheme.primaryColor)),
            Text("Nombre d'espèces trouvées",
                style: TextStyle(color: AppTheme.secondaryText)),
          ],
        ),
      ],
    );
  }
}
