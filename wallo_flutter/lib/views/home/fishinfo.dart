import 'package:flutter/material.dart';
import 'package:wallo_flutter/views/home/PopUp_Fish.dart';

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
  }) : super(key: key);

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
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            if (widget.isunlocked == true) {
              showDialog(
                context: context,
                builder: (BuildContext context) => PopupFish(
                  fishName: widget.fishname,
                  scientificName: widget.scientificName,
                  url: widget.urlfish,
                  description: widget.description,
                ),
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
                        ? "https://wall-o.herokuapp.com/assets/aquadex/" +
                            widget.slug +
                            ".png"
                        : "https://wall-o.herokuapp.com/assets/aquadex/" +
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.fishname,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
