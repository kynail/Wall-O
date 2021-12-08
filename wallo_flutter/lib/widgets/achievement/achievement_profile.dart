import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class AchievementProfile extends StatelessWidget {
  const AchievementProfile({
    Key key,
    @required this.unlockedImagePath,
    @required this.title,
    @required this.description,
    @required this.lockedImagePath,
    @required this.isUnlocked,
    @required this.xp,
  }) : super(key: key);

  final String unlockedImagePath;
  final String lockedImagePath;
  final String title;
  final String description;
  final int xp;
  final bool isUnlocked;

  showPopUp(BuildContext context) {
    return showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Stack(children: <Widget>[
            Image.asset(
              "assets/pop.png",
              fit: BoxFit.cover,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
            )
          ]),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              SizedBox(height: 8),
              Text(
                "${xp.toString()} points d'expérience",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showPopUp(context),
      child: Image(
        image: AssetImage(
          isUnlocked ? unlockedImagePath : lockedImagePath,
        ),
        width: 50,
      ),
    );
  }
}
