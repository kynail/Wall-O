import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallo_flutter/screens/analyze_picture_screen.dart';
import 'package:wallo_flutter/views/home/aquadex.dart';
import 'package:wallo_flutter/views/home/take_picture.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.camera, @required this.appBarHeight})
      : super(key: key);

  final CameraDescription camera;
  final double appBarHeight;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    print("INIT STATE");
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  configCamera() {
    _controller.setFlashMode(FlashMode.off);
  }

  onTakePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalyzeScreen(
            imagePath: image?.path,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  onOpenGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalyzeScreen(
            imagePath: image?.path,
          ),
        ),
      );
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var camera = _controller.value;
          var size = MediaQuery.of(context).size;
          var width = size.width;
          var height = size.height - widget.appBarHeight;
          var scale = (width / height) * camera.aspectRatio;
          if (scale < 1) scale = 1 / scale;
          configCamera();

          return PageView(
            scrollDirection: Axis.vertical,
            controller: pageController,
            children: [
              TakePicture(
                appBarHeight: widget.appBarHeight,
                camera: widget.camera,
                scale: scale,
                controller: _controller,
                onTakePicture: () => onTakePicture(),
                onOpenGallery: () => onOpenGallery(),
                onArrowTap: () {
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastOutSlowIn);
                },
              ),
              Aquadex()
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
      },
    );
  }
}
