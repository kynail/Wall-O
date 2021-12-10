import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wallo_flutter/models/achievement.dart';
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
    @required this.achievements,
    @required this.onDisconnect,
  }) : super(key: key);

  final Function() onCloseArrowTap;
  final User user;
  final Function(double xp) addExp;
  final Function(String, String) onSaveAvatarPressed;
  final List<Achievement> achievements;
  final Function(BuildContext context) onDisconnect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FloatingPageTopBar(
            onCloseArrowTap: onCloseArrowTap,
            title: "Profil",
            showHelp: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 1000),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 100.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        ProfileMainInfo(
                          user: user,
                          onSaveAvatarPressed: onSaveAvatarPressed,
                        ),
                        SizedBox(height: 12),
                        if (achievements.isNotEmpty)
                          SizedBox(
                            height: 300,
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              children: achievements
                                  .map(
                                    (achievement) => AchievementProfile(
                                      title: achievement.title,
                                      description: achievement.description,
                                      unlockedImagePath: "assets/star.png",
                                      lockedImagePath: "assets/starblack.jpeg",
                                      xp: achievement.xp,
                                      isUnlocked:
                                          user.level.achievements.contains(
                                        achievement.uniqueName,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: () {
                            onDisconnect(context);
                            // Navigator.of(context).pushReplacementNamed("/");
                          },
                          child: Text("Se déconnecter"),
                        )
                      ],
                    ),
                  ),
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
