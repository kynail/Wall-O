import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wallo_flutter/views/home/take_picture.dart';

class Camera extends StatefulWidget {
  final CameraDescription camera;

  const Camera({Key key, @required this.camera}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TakePicture(camera: widget.camera),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: IconButton(
              icon: const Icon(Icons.lens_outlined),
              onPressed: () async {},
              iconSize: 100,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
