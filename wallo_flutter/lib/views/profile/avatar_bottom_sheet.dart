import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/user.dart';
import 'edit_avatar.dart';

class AvatarBottomSheet extends StatefulWidget {
  const AvatarBottomSheet({
    Key key,
    this.user,
  }) : super(key: key);

  final User user;

  @override
  _AvatarBottomSheetState createState() => _AvatarBottomSheetState();
}

class _AvatarBottomSheetState extends State<AvatarBottomSheet> {
  double _size = 500;
  Widget _animatedWidget;

  Widget mainWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text('Modifier sa photo de profil', style: TextStyle(fontSize: 22)),
            SizedBox(height: 18),
            ElevatedButton(
              child: const Text('Générer son avatar',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onPressed: () {
                setState(() {
                  _animatedWidget = EditAvatar(user: widget.user);
                  _size = 500;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(width: 18),
                Text("OU CHOISIR UNE IMAGE"),
                SizedBox(width: 18),
                Flexible(
                  child: Divider(
                    thickness: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              children: [
                ElevatedButton(
                  child: const Text('Ouvrir la galerie',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text("Ouvrir l'appareil photo",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animatedWidget = EditAvatar(user: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        height: _size,
        child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400), child: _animatedWidget));
  }
}
