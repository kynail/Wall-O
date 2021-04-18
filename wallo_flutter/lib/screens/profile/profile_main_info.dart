import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/redux/state/app_state.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/state/user/user_state.dart';
import 'package:wallo_flutter/screens/profile/avatar_bottom_sheet.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';

class ProfileMainInfo extends StatefulWidget {
  const ProfileMainInfo({
    Key key,
    this.user,
  }) : super(key: key);

  final User user;

  @override
  _ProfileMainInfoState createState() => _ProfileMainInfoState();
}

class _ProfileMainInfoState extends State<ProfileMainInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserInfo(user: widget.user),
          SizedBox(height: 28),
          XpBar(user: widget.user),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}

class XpBar extends StatelessWidget {
  const XpBar({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Niveau : " + user.level.level.toString(),
          style: TextStyle(fontSize: 18)),
      SizedBox(height: 12),
      LinearProgressIndicator(
        value: (user.level.xp / user.level.nextLvl.toDouble() * 100) / 100,
        semanticsLabel: "Indicateur d'expérience",
        valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
        backgroundColor: AppTheme.lightGrey,
      ),
      SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
            (user.level.xp).toStringAsFixed(0) +
                " / " +
                user.level.nextLvl.toDouble().toStringAsFixed(0),
            style: TextStyle(fontSize: 16, color: AppTheme.secondaryText)),
        Text("Expérience",
            style: TextStyle(fontSize: 16, color: AppTheme.secondaryText))
      ]),
    ]);
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  void onAvatarTap(BuildContext context, UserState userState) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        builder: (BuildContext context) {
          return AvatarBottomSheet(user: widget.user);
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        distinct: true,
        converter: (store) => store.state.userState,
        builder: (context, userState) {
          return Column(
            children: [
              Stack(
                children: [
                  if (widget.user.avatar != null)
                    AvatarLayout(avatar: widget.user.avatar),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          onAvatarTap(context, userState);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              if (widget.user.firstName != null && widget.user.lastName != null)
                Text(
                  widget.user.firstName + " " + widget.user.lastName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 4),
              if (widget.user.mail != null)
                Text(
                  "(" + widget.user.mail + ")",
                  style: TextStyle(fontSize: 14),
                ),
            ],
          );
        });
  }
}

class AddExp extends StatefulWidget {
  const AddExp({
    Key key,
    this.user,
  }) : super(key: key);

  final User user;

  @override
  _AddExpState createState() => _AddExpState();
}

class _AddExpState extends State<AddExp> {
  double _plusValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Redux.store.dispatch(
                //     (store) => setExp(store, widget.user, _plusValue));
              }),
        ),
        SizedBox(width: 25),
        Flexible(
          child: TextField(
            onChanged: (value) {
              setState(() {
                _plusValue = double.parse(value);
              });
            },
            decoration: InputDecoration(labelText: "Nombre"),
          ),
        ),
      ],
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
