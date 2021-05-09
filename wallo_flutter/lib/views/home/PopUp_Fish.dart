import 'package:flutter/material.dart';

class PopupFish extends StatelessWidget {
  const PopupFish({Key key, this.url, this.description}) : super(key: key);
  final String url;
  final String description;

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('More information'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(url),
          SizedBox(
            height: 8,
          ),
          Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            description
          ),
        ],
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
