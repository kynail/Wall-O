import 'dart:io';

import 'package:camera/camera.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/screens/analyze_picture_screen.dart';
import 'package:wallo_flutter/screens/aquadex_screen.dart';
import 'package:wallo_flutter/screens/contact.dart';
import 'package:wallo_flutter/screens/leaderboard_screen.dart';
import 'package:wallo_flutter/screens/profile_screen.dart';
import 'package:wallo_flutter/views/home/take_picture.dart';
import 'package:wallo_flutter/views/profile/profile_main_info.dart';
import 'package:wallo_flutter/wall_o_icons.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
    @required this.cameraController,
    @required this.appBarHeight,
    @required this.user,
  }) : super(key: key);

  final User user;
  final CameraController cameraController;
  final double appBarHeight;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  HomeAnimationController _profileAnimationControler;
  HomeAnimationController _leaderBoardAnimationControler;
  HomeAnimationController _contactAnimationControler;
  // CameraController _controller;
  // Future<void> _initializeControllerFuture;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // _controller = CameraController(
    //   widget.camera,
    //   ResolutionPreset.medium,
    // );

    // _initializeControllerFuture = _controller.initialize();

    _profileAnimationControler = HomeAnimationController(
      AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    _leaderBoardAnimationControler = HomeAnimationController(
      AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );

    _contactAnimationControler = HomeAnimationController(
      AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
  }

  onTakePicture() async {
    try {
      // await _initializeControllerFuture;
      final image = await widget.cameraController.takePicture();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalyzeScreen(
            isFromGallery: false,
            imagePath: image?.path,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  onOpenGallery() async {
    var longitude;
    var latitude;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      final fileBytes = image.readAsBytesSync();
      final data = await readExifFromBytes(fileBytes, details: false);

      for (String key in data.keys) {
        if (key == "GPS GPSLatitude") {
          print("LATITUDE = ${data[key]}");
          Ratio first = data[key].values[0];
          Ratio nb = data[key].values[1];
          double div = nb.numerator / 60;
          final res = first.numerator + div;

          latitude = res;
        } else if (key == "GPS GPSLongitude") {
          Ratio first = data[key].values[0];
          Ratio nb = data[key].values[1];
          double div = nb.numerator / 60;
          final res = first.numerator + div;

          longitude = res;
        }
        // print("key ${data[key].tagType}:${key}  - ${data[key]}");
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalyzeScreen(
            isFromGallery: true,
            latitude: latitude,
            longitude: longitude,
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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final PageController pageController = PageController(initialPage: 0);

    var scale = 1 /
        (widget.cameraController.value.aspectRatio *
            MediaQuery.of(context).size.aspectRatio);

    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.vertical,
          controller: pageController,
          children: [
            Stack(
              children: [
                TakePicture(
                  appBarHeight: widget.appBarHeight,
                  scale: scale,
                  controller: widget.cameraController,
                  onTakePicture: () => onTakePicture(),
                  onOpenGallery: () => onOpenGallery(),
                  onArrowTap: () {
                    pageController.animateToPage(1,
                        duration: Duration(milliseconds: 600),
                        curve: Curves.fastOutSlowIn);
                  },
                ),
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: statusBarHeight + 8,
                      left: 16,
                      right: 16,
                    ),
                    child: TopBar(
                      user: widget.user,
                      onAvatarTap: () {
                        showMaterialModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (BuildContext context) {
                            return ProfileScreen(
                              onCloseArrowTap: () =>
                                  Navigator.of(context).pop(),
                            );
                          },
                        );
                      },
                      onLeaderboardTap: () {
                        showMaterialModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (BuildContext context) {
                            return LeaderboardScreen(
                              onCloseArrowTap: () =>
                                  Navigator.of(context).pop(),
                            );
                          },
                        );
                      },
                      onContactTap: () {
                        showMaterialModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Contact(
                              onCloseArrowTap: () =>
                                  Navigator.of(context).pop(),
                            );
                          },
                        );
                        _contactAnimationControler.controller.forward();
                      },
                    ),
                  ),
                ),
              ],
            ),
            AquadexScreen(
              pageController: pageController,
            ),
          ],
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  final Function() onAvatarTap;
  final Function() onLeaderboardTap;
  final Function() onContactTap;
  final User user;

  const TopBar({
    Key key,
    @required this.user,
    @required this.onAvatarTap,
    @required this.onLeaderboardTap,
    @required this.onContactTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarLayout(
          showEdit: false,
          width: 35,
          avatar: user.avatar,
          onTap: onAvatarTap,
        ),
        SizedBox(
          width: 24,
        ),
        InkWell(
          onTap: onLeaderboardTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 12.0,
                right: 12.0,
                bottom: 8.0,
              ),
              child: Icon(
                WallO.crown,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: onContactTap,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
              child: Icon(
                WallO.question,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 24,
        ),
        InkWell(
          onTap: () => Navigator.of(context).pushReplacementNamed("/"),
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeAnimationController {
  AnimationController controller;
  Animation<Offset> offset;

  HomeAnimationController(AnimationController animationController) {
    controller = animationController;

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller.drive(
      CurveTween(curve: Curves.fastOutSlowIn),
    ));
  }
}
