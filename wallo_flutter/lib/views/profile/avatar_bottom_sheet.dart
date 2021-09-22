import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/user.dart';
import 'edit_avatar.dart';

class AvatarBottomSheet extends StatefulWidget {
  final Function(String, String) onSaveAvatarPressed;
  const AvatarBottomSheet({
    Key key,
    @required this.user,
    @required this.onSaveAvatarPressed,
  }) : super(key: key);

  final User user;

  @override
  _AvatarBottomSheetState createState() => _AvatarBottomSheetState();
}

class _AvatarBottomSheetState extends State<AvatarBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: EditAvatar(
        user: widget.user,
        onSaveAvatarPressed: widget.onSaveAvatarPressed,
      ),
    );
  }
}
