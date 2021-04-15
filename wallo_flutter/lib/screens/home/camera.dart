import 'package:flutter/material.dart';

import '../../theme.dart';

class Camera extends StatelessWidget {
  const Camera({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: FractionalOffset.center,
          child: Image(
            image: NetworkImage(
                "https://i.pinimg.com/originals/1b/96/1f/1b961f1d36d37bd3f7df7f3783c6eb7b.jpg"),
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: IconButton(
              icon: const Icon(Icons.lens_outlined),
              onPressed: () {},
              iconSize: 100,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
