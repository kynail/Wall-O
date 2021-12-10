import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/widgets/Popup_Map.dart';

class FishInfo extends StatefulWidget {
  const FishInfo({
    Key key,
    @required this.fishId,
    @required this.fishname,
    @required this.urlfish,
    @required this.description,
    @required this.scientificName,
    @required this.slug,
    this.isunlocked,
    @required this.location,
  }) : super(key: key);

  final FishLocation location;
  final String fishId;
  final String fishname;
  final String scientificName;
  final String urlfish;
  final String description;
  final String slug;
  final bool isunlocked;

  @override
  _FishInfoState createState() => _FishInfoState();
}

class _FishInfoState extends State<FishInfo> {
  bool boolean = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          //color: Colors.blueGrey,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            if (widget.isunlocked == true) {
              showAnimatedDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fishname,
                          style: TextStyle(fontSize: 22),
                        ),
                        Text(
                          widget.scientificName,
                          style: TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    content:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      Image.asset(
                        "assets/fondaq.png",
                        fit: BoxFit.cover,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image.network(widget.urlfish),
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
                            Text(widget.description),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(widget.location.lat);
                                    print(widget.location.long);
                                    showDialog(
                                      builder: (BuildContext context) => PopupMap(
                                          latitude: -20.463043,
                                          longitude: 53.572621, zoom: null,), context: context,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text("Localisation"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                    actions: <Widget>[
                      new TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Fermer'),
                      ),
                    ],
                  );
                },
                animationType: DialogTransitionType.fadeRotate,
                curve: Curves.fastOutSlowIn,
                duration: Duration(seconds: 1),
              );
            }
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    widget.isunlocked
                        ? "${env["API_URL"]}/assets/aquadex-slug/" +
                            widget.slug +
                            ".png"
                        : "${env["API_URL"]}/assets/aquadex-slug/" +
                            widget.slug +
                            "-black.png",
                    height: 125,
                    width: double.infinity,
                    fit: BoxFit.scaleDown,
                  ),
                  // Image(
                  //   image: AssetImage(widget.isunlocked
                  //       ? "assets/aquadex/" + widget.slug + ".png"
                  //       : "assets/aquadex/" + widget.slug + "-black.png"),
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: Text(
                  //     widget.fishname,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
