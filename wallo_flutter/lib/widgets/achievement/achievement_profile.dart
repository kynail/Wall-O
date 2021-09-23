import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
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
