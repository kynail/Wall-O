import 'package:flutter/material.dart';
import 'package:wallo_flutter/wall_o_icons.dart';

class FloatingPageTopBar extends StatelessWidget {
  final Function() onCloseArrowTap;
  final String title;

  const FloatingPageTopBar({
    Key key,
    @required this.onCloseArrowTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          SizedBox(height: 18),
          Stack(
            children: [
              Positioned(
                left: 0,
                top: -16,
                bottom: -8,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: onCloseArrowTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(WallO.down_open),
                  ),
                ),
              ),
              Align(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
