import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class PopupFish extends StatelessWidget {
  const PopupFish({
    Key key,
    @required this.url,
    @required this.description,
    @required this.fishName,
    @required this.scientificName,
  }) : super(key: key);

  final String fishName;
  final String scientificName;
  final String url;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.only(left: 15.0),
              height: 35.0,
              alignment: Alignment.centerLeft,
              child: Text('General dialog'),
              color: const Color(0xFFDDDDDD),
            ),
            Divider(
              height: 0.5,
            ),
            ListTile(
              title: Text(
                "Fade rotate",
              ),
              onTap: () {
                showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fishName,
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            scientificName,
                            style: TextStyle(
                                fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(url),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Description",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(description),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                  animationType: DialogTransitionType.fadeRotate,
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(seconds: 1),
                );
              },
            ),
            Divider(
              height: 0.5,
            ),
          ],
        ),
      ),
    );
    //   AlertDialog(
    //     title: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           fishName,
    //           style: TextStyle(fontSize: 22),
    //         ),
    //         Text(
    //           scientificName,
    //           style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
    //         ),
    //       ],
    //     ),
    //     content: SingleChildScrollView(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Image.network(url),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Text(
    //             "Description",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(
    //             height: 12,
    //           ),
    //           Text(description),
    //         ],
    //       ),
    //     ),
    //     actions: <Widget>[
    //       new TextButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: const Text('Close'),
    //       ),
    //     ],
    //   );
    // }
  }
}
