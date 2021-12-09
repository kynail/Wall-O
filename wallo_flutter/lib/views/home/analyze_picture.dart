import 'dart:io';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/widgets/Popup_Map.dart';
import 'package:wallo_flutter/widgets/percent.dart';

class AnalyzePicture extends StatefulWidget {
  final bool isFromGallery;
  final double latitude;
  final double longitude;
  final String imagePath;
  final bool isLoading;
  final List<AquadexFish> fishes;
  final Function() onDispose;
  final Function() onInit;

  const AnalyzePicture({
    Key key,
    this.imagePath,
    @required this.isLoading,
    this.fishes,
    this.onDispose,
    this.latitude,
    this.longitude,
    this.isFromGallery,
    this.onInit,
  }) : super(key: key);

  @override
  _AnalyzePictureState createState() => _AnalyzePictureState();
}

class _AnalyzePictureState extends State<AnalyzePicture>
    with SingleTickerProviderStateMixin {
  AnimationController _bottomSheetAnimController;
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    widget.onInit();
    super.initState();
    _bottomSheetAnimController =
        AnimationController(vsync: this, duration: _duration);
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fishes != null && widget.fishes.length > 0) {
      _bottomSheetAnimController.forward();
    }

    return Stack(
      children: [
        Center(child: Image.file(File(widget.imagePath))),
        AnimatedOpacity(
          opacity: widget.isLoading ? 0.5 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            color: Colors.black,
          ),
        ),
        if (widget.isLoading == true)
          Center(
            child: Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_IVn5L1.json'),
          ),
        if (widget.isLoading == true)
          Center(
              child: Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_n9LEii.json')),
        SlideTransition(
          position: _tween.animate(_bottomSheetAnimController),
          child: DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return !widget.isLoading
                    ? FishDetails(
                        isFromGallery: widget.isFromGallery,
                        latitude: widget.latitude,
                        longitude: widget.longitude,
                        fishes: widget.fishes,
                        scrollController: scrollController,
                      )
                    : Container();
              }),
        )
      ],
    );
  }
}

class FishDetails extends StatefulWidget {
  final bool isFromGallery;
  final double latitude;
  final double longitude;

  const FishDetails({
    Key key,
    @required this.fishes,
    @required this.scrollController,
    this.latitude,
    this.longitude,
    @required this.isFromGallery,
  }) : super(key: key);

  final List<AquadexFish> fishes;
  final ScrollController scrollController;

  @override
  _FishDetailsState createState() => _FishDetailsState();
}

class _FishDetailsState extends State<FishDetails> {
  Position _currentPosition;
  String _currentAddress;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: false)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(
            _currentPosition.latitude, _currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      _getAddressFromLatLng(widget.latitude, widget.longitude);
    } else {
      if (!widget.isFromGallery) {
        _getCurrentLocation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            children: [
              SizedBox(height: 16),
              Text("Résultats :", style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              if (widget.fishes != null && widget.fishes.length > 0)
                Column(
                  children: widget.fishes
                      .map(
                        (aquadexFish) => Wrap(
                          runSpacing: 8,
                          spacing: 12,
                          alignment: WrapAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(aquadexFish.image),
                            Text(
                              aquadexFish.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              " (${(aquadexFish.fish.confidence * 100).toStringAsFixed(0)} %)",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(height: 32),
                            Percent(pourcent: aquadexFish.fish.confidence),
                            MoreInfoWithTitle(
                              title: "Nom scientifique",
                              body: aquadexFish.scientificName,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              widget.fishes != null
                  ? Column(
                      children: [
                        Column(
                          children: widget.fishes
                              .toSet()
                              .toList()
                              .asMap()
                              .map(
                                (i, aquadexFish) => MapEntry(
                                  i,
                                  Wrap(
                                    runSpacing: 24,
                                    spacing: 16,
                                    children: [
                                      MoreInfoWithTitle(
                                        title: "",
                                        body: aquadexFish.desc,
                                      ),
                                      if (_currentAddress != null)
                                        MoreInfoWithTitle(
                                          title: "Localisation de la photo",
                                          body: _currentAddress,
                                        ),
                                      if (i !=
                                          widget.fishes
                                                  .toSet()
                                                  .toList()
                                                  .length -
                                              1)
                                        Divider(),
                                      Center(
                                          child: Container(
                                              width: 250,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.lightBlueAccent,
                                                          onPrimary:
                                                              Colors.white),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            PopupMap(latitude: widget.latitude??_currentPosition.latitude, longitude: widget.longitude??_currentPosition.longitude));
                                                  }, child: const Text("Voir sur la carte"),))),
                                      SizedBox(
                                        height: 0,
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class MoreInfoWithTitle extends StatelessWidget {
  const MoreInfoWithTitle({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            body,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
