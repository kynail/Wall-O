import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

import 'analyze_picture.dart';

class Import extends StatefulWidget {
  const Import({Key key}) : super(key: key);

  @override
  _ImportState createState() => _ImportState();
}

class _ImportState extends State<Import> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnalyzePicture(
              isLoading: false,
              imagePath: _image?.path,
            ),
          ),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image(
            image: NetworkImage(
                "https://media.gerbeaud.net/2019/11/640/amphiprion-ocellaris-poisson-clown-pacifique.jpg"),
          ),
        ),
        LoadingButton(
            isLoading: false,
            onPressed: () {
              getImage();
            },
            child: Text(
              "Importer",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
