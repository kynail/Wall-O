import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TakePicture extends StatefulWidget {
  final double scale;
  final CameraController controller;
  final Function() onTakePicture;
  final Function() onOpenGallery;
  final Function() onArrowTap;
  final double appBarHeight;

  TakePicture({
    Key key,
    @required this.scale,
    @required this.controller,
    @required this.onTakePicture,
    @required this.onOpenGallery,
    @required this.appBarHeight,
    @required this.onArrowTap,
  }) : super(key: key);

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
          alignment: Alignment.topCenter,
          child: CameraPreview(
            widget.controller,
          ),
        ),
        Align(alignment: Alignment.center, child: Image(image: AssetImage('assets/Cadre.png'))),
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
              AnimatedIconButton(onTakePicture: onTakePicture),
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

class AnimatedIconButton extends StatefulWidget {
  AnimatedIconButton({Key key, @required this.onTakePicture}) : super(key: key);

  final Function() onTakePicture;
  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with TickerProviderStateMixin {
  AnimationController _iconAnimationController;

  @override
  void initState() {
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 125),
      value: 1.0,
      lowerBound: 1.00,
      upperBound: 1.45,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _iconAnimationController,
      child: IconButton(
        icon: Image.asset('assets/boutton_TakePicture_WallOLogo.png'),
        onPressed: () {
          _onTap();
          widget.onTakePicture();
        },
        iconSize: 100,
        color: Colors.white,
      ),
    );
  }

  void _onTap() {
    _iconAnimationController.forward().then((value) {
      _iconAnimationController.reverse();
    });
  }
}
