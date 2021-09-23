import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/views/floating_page_top_bar.dart';
import 'package:wallo_flutter/views/profile/profile_main_info.dart';
import 'package:wallo_flutter/widgets/achievement/achievement_profile.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key key,
    @required this.user,
    @required this.addExp,
    @required this.onCloseArrowTap,
    @required this.onSaveAvatarPressed,
  }) : super(key: key);

  final Function() onCloseArrowTap;
  final User user;
  final Function(double xp) addExp;
  final Function(String, String) onSaveAvatarPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FloatingPageTopBar(onCloseArrowTap: onCloseArrowTap, title: "Profil"),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileMainInfo(
                      user: user,
                      onSaveAvatarPressed: onSaveAvatarPressed,
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 300,
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        children: [
                          AchievementProfile(
                            unlockedImagePath: "assets/star.png",
                            description: "Première connexion",
                            title: "Explorateur",
                            lockedImagePath: "assets/starblack.jpeg",
                            isUnlocked: false,
                          ),
                          AchievementProfile(
                            unlockedImagePath: "assets/star.png",
                            description: "Premier poisson trouvé",
                            title: "Apprenti plongeur",
                            lockedImagePath: "assets/starblack.jpeg",
                            isUnlocked: false,
                          ),
                          AchievementProfile(
                            unlockedImagePath: "assets/star.png",
                            description: "5ème poisson trouvé",
                            title: "Plongeur averti",
                            lockedImagePath: "assets/starblack.jpeg",
                            isUnlocked: false,
                          ),
                          AchievementProfile(
                            unlockedImagePath: "assets/star.png",
                            description: "10ème poisson trouvé",
                            title: "Fou de la plongée",
                            lockedImagePath: "assets/starblack.jpeg",
                            isUnlocked: false,
                          ),
                          AchievementProfile(
                            unlockedImagePath: "assets/star.png",
                            description: "Tous les poissons trouvés",
                            title: "Maître des poissons",
                            lockedImagePath: "assets/starblack.jpeg",
                            isUnlocked: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileFishInfo extends StatelessWidget {
  const ProfileFishInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              Text("26",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppTheme.primaryColor)),
              Text(
                "Nombre de poissons trouvés",
                style: TextStyle(
                  color: AppTheme.secondaryText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text("5",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppTheme.primaryColor)),
            Text("Nombre d'espèces trouvées",
                style: TextStyle(
                  color: AppTheme.secondaryText,
                  fontSize: 12,
                )),
          ],
        ),
      ],
    );
  }
}
