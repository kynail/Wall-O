import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/views/profile/profile_main_info.dart';

class Profile extends StatelessWidget {
  const Profile({Key key, @required this.user, @required this.addExp})
      : super(key: key);
  final User user;
  final Function(double xp) addExp;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ProfileMainInfo(user: user),
          SizedBox(height: 12),
          ProfileFishInfo(),
          SizedBox(height: 60),
          Divider(thickness: 2),
          AddExp(user: user, addExp: (xp) => addExp(xp))
        ],
      ),
    ));
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
