import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/screens/profile/avatar_bottom_sheet.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/models/avatar.dart';

class ProfileMainInfo extends StatelessWidget {
  const ProfileMainInfo({
    Key key,
    this.user,
  }) : super(key: key);

  final User user;

  void onAvatarTap(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        builder: (BuildContext context) {
          return AvatarBottomSheet(user: user);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              AvatarLayout(avatar: user.avatar),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () {
                      onAvatarTap(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            user.firstName + " " + user.lastName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "(" + user.mail + ")",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 28),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Niveau : 1", style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.2,
              semanticsLabel: 'Linear progress indicator',
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
              backgroundColor: AppTheme.lightGrey,
            ),
            SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("20 / 100",
                  style:
                      TextStyle(fontSize: 16, color: AppTheme.secondaryText)),
              Text("Expérience",
                  style: TextStyle(fontSize: 16, color: AppTheme.secondaryText))
            ]),
          ]),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}

class AvatarLayout extends StatelessWidget {
  const AvatarLayout({
    Key key,
    this.avatar,
  }) : super(key: key);

  final Avatar avatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (avatar?.seed != null && avatar?.type != null)
            ? SvgPicture.network(
                'https://avatars.dicebear.com/api/${avatar.type}/${avatar.seed}.svg?r=50&b=%23fff7d4',
                semanticsLabel: 'Avatar',
                width: 100,
                placeholderBuilder: (BuildContext context) =>
                    Container(child: const CircularProgressIndicator()),
              )
            : CircleAvatar(
                backgroundImage: AssetImage("assets/avatar.png"),
                radius: 50,
              ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.edit),
              )),
        )
      ],
    );
  }
}
