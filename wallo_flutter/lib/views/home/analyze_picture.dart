import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wallo_flutter/models/Fish.dart';
import 'package:wallo_flutter/theme.dart';

class AnalyzePicture extends StatefulWidget {
  final bool isFromGallery;
  final double latitude;
  final double longitude;
  final String imagePath;
  final bool isLoading;
  final List<Fish> fishes;
  final Function() onDispose;

  const AnalyzePicture({
    Key key,
    this.imagePath,
    @required this.isLoading,
    this.fishes,
    this.onDispose,
    this.latitude,
    this.longitude,
    @required this.isFromGallery,
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
    print("FISHES ${widget.fishes}");
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
          Center(child: CircularProgressIndicator(strokeWidth: 2)),
        SlideTransition(
          position: _tween.animate(_bottomSheetAnimController),
          child: DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return FishDetails(
                  isFromGallery: widget.isFromGallery,
                  latitude: widget.latitude,
                  longitude: widget.longitude,
                  fishes: widget.fishes,
                  scrollController: scrollController,
                );
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

  final List<Fish> fishes;
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
      print("POSITION $position");
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

        print("Current Address $_currentAddress");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      print("Latitude from gallery");
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
                        (fish) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fish.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              " (${(fish.confidence * 100).toStringAsFixed(0)} %)",
                              style: TextStyle(
                                  fontSize: 20, fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              SizedBox(height: 16),
              Text("Plus d'informations"),
              Icon(Icons.expand_more_outlined),
              SizedBox(height: 16),
              if (_currentAddress != null)
                Column(
                  children: [
                    Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text(_currentAddress),
                    ),
                  ],
                ),
              Container(height: 500)
            ],
          ),
        ),
      ),
    );
  }
}
