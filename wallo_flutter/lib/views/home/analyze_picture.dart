import 'dart:io';

import 'package:flutter/material.dart';

class AnalyzePicture extends StatelessWidget {
  final String imagePath;

  const AnalyzePicture({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Analyser la photo'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
