import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/new_achievement.dart';
import 'package:wallo_flutter/widgets/achievement/modal_confetti.dart';

class AchievementLayout extends StatelessWidget {
  const AchievementLayout({
    Key key,
    @required this.globalKey,
    @required this.newAchievement,
    @required this.onClose,
  }) : super(key: key);

  final GlobalKey<ModalConfettiState> globalKey;
  final NewAchievement newAchievement;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            SizedBox(height: 12),
            Image(
              image: AssetImage("assets/star.png"),
              width: 120,
            ),
            SizedBox(height: 12),
            Text(
              "Félicitations, vous avez obtenu un nouveau trophée",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Text(
              newAchievement.achievement.title,
              style: TextStyle(
                fontSize: 22,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 12),
            Text(
              newAchievement.achievement.description,
              style: TextStyle(),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(0.1),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff4BBCFC),
                            ),
                          ),
                          child: Text(
                            "Fermer",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            globalKey.currentState.closeModal();
                            onClose();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
