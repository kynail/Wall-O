import 'package:flutter/material.dart';
import 'package:wallo_flutter/views/home/PopUp_Fish.dart';

class FishInfo extends StatefulWidget {
  const FishInfo({Key key, this.fishname, this.urlfish, this.description,})
      : super(key: key);
  final String fishname;
  final String urlfish;
  final String description;

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
            //Navigator.of(context).pushReplacementNamed("/fishclicked");
            showDialog(
              context: context,
              builder: (BuildContext context) => PopupFish(url: widget.urlfish, description: widget.description,
              ),
            );
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(widget.urlfish),
                  SizedBox(height: 8,),
                  Flexible(
                    child: Text(
                      widget.fishname,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
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
