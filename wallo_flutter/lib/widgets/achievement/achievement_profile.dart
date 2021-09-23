import 'package:flutter/material.dart';

class AchievementProfile extends StatelessWidget {
  const AchievementProfile(
      {Key key,
      this.unlockedImagePath,
      this.title,
      this.description,
      this.lockedImagePath,
      this.isUnlocked})
      : super(key: key);

  final String unlockedImagePath;
  final String lockedImagePath;
  final String title;
  final String description;
  final bool isUnlocked;

  showPopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
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
