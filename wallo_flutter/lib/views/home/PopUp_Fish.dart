import 'package:flutter/material.dart';

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
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
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
  }
}
