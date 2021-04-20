import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wallo_flutter/views/home/analyze_picture.dart';
import 'dart:math' as math;

class TakePicture extends StatefulWidget {
  final CameraDescription camera;
  final double scale;
  final CameraController controller;
  final Function() onTakePicture;
  final Function() onOpenGallery;
  final Function() onArrowTap;
  final double appBarHeight;

  TakePicture(
      {Key key,
      @required this.camera,
      @required this.scale,
      @required this.controller,
      @required this.onTakePicture,
      @required this.onOpenGallery,
      @required this.appBarHeight,
      @required this.onArrowTap})
      : super(key: key);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.scale(
            scale: widget.scale,
            child: Padding(
              padding: EdgeInsets.only(top: widget.appBarHeight + 0.5),
              child: CameraPreview(
                widget.controller,
              ),
            )),
        TakePictureButtons(
          onTakePicture: () => widget.onTakePicture(),
          onOpenGallery: () => widget.onOpenGallery(),
          onArrowTap: () => widget.onArrowTap(),
        ),
      ],
    );
  }
}

class TakePictureButtons extends StatelessWidget {
  const TakePictureButtons({
    Key key,
    @required this.onTakePicture,
    @required this.onOpenGallery,
    @required this.onArrowTap,
  }) : super(key: key);

  final Function() onTakePicture;
  final Function() onOpenGallery;
  final Function() onArrowTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              IconButton(
                icon: const Icon(Icons.lens_outlined),
                onPressed: () => onTakePicture(),
                iconSize: 100,
                color: Colors.white,
              ),
              Expanded(
                  child: Row(
                children: [
                  SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.collections_outlined),
                    onPressed: () => onOpenGallery(),
                    iconSize: 35,
                    color: Colors.white,
                  ),
                ],
              )),
            ],
          ),
          IconButton(
            icon: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: const Icon(Icons.expand_more_outlined)),
            onPressed: () => onArrowTap(),
            iconSize: 35,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
