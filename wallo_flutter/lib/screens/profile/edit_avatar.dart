import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallo_flutter/theme.dart';

class EditAvatar extends StatefulWidget {
  EditAvatar({Key key}) : super(key: key);

  @override
  _EditAvatarState createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  String dropdownValue = 'male';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff804645),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.network(
              'https://avatars.dicebear.com/api/$dropdownValue/.svg?r=50&b=%fff',
              semanticsLabel: 'Avatar',
              width: 200,
              placeholderBuilder: (BuildContext context) =>
                  Container(child: const CircularProgressIndicator()),
            ),
          ),
        ),
        SizedBox(height: 30),
        Column(
          children: [
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(height: 2, color: AppTheme.primaryColor),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>[
                'male',
                'female',
                'human',
                'identicon',
                'initials',
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
          child: TextField(
            decoration: InputDecoration(labelText: "Entrez une valeure"),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: const Text("Enregistrer",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {},
        ),
      ],
    );
  }
}
