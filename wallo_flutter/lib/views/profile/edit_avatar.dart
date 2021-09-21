import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/theme.dart';

class EditAvatar extends StatefulWidget {
  final Function(String seed, String dropdownValue) onSaveAvatarPressed;
  EditAvatar({
    Key key,
    @required this.user,
    @required this.onSaveAvatarPressed,
  }) : super(key: key);
  final User user;

  @override
  _EditAvatarState createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  String _dropdownValue = 'male';
  String _seed = '';

  @override
  void initState() {
    if (widget.user.avatar.seed != null) {
      _seed = widget.user.avatar.seed;
    }
    if (widget.user.avatar.type != null) {
      _dropdownValue = widget.user.avatar.type;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff804645),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 200,
              height: 200,
              child: SvgPicture.network(
                'https://avatars.dicebear.com/api/$_dropdownValue/$_seed.svg?r=50&b=%23CC6664',
                semanticsLabel: 'Avatar',
                width: 200,
                placeholderBuilder: (BuildContext context) =>
                    Container(child: const CircularProgressIndicator()),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Column(
          children: [
            DropdownButton<String>(
              value: _dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(height: 2, color: AppTheme.primaryColor),
              onChanged: (String newValue) {
                setState(() {
                  _dropdownValue = newValue;
                });
              },
              items: <String>[
                'male',
                'female',
                'human',
                'identicon',
                'bottts',
                'avataaars',
                'jdenticon',
                'gridy',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                _seed = value;
              });
            },
            initialValue: _seed,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Ecrivez quelque chose',
              border: InputBorder.none,
              fillColor: Color(0xfffff6d4),
              filled: true,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: const Text("Enregistrer",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            widget.onSaveAvatarPressed(_seed, _dropdownValue);
          },
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
