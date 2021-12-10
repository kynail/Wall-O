import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallo_flutter/screens/contact.dart';
import 'package:wallo_flutter/wall_o_icons.dart';

class FloatingPageTopBar extends StatelessWidget {
  final Function() onCloseArrowTap;
  final String title;
  final bool showHelp;

  const FloatingPageTopBar({
    Key key,
    @required this.onCloseArrowTap,
    @required this.title,
    this.showHelp = false,
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
              if (showHelp)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          // expand: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Contact(
                              onCloseArrowTap: () =>
                                  Navigator.of(context).pop(),
                            );
                          },
                        );
                      },
                      child: Icon(
                        WallO.question,
                        size: 14,
                      ),
                    ),
                  ),
                ),
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
