import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/Fish.dart';
import 'package:wallo_flutter/theme.dart';

class AnalyzePicture extends StatefulWidget {
  final String imagePath;
  final bool isLoading;
  final List<Fish> fishes;
  final Function() onDispose;

  const AnalyzePicture(
      {Key key,
      this.imagePath,
      @required this.isLoading,
      this.fishes,
      this.onDispose})
      : super(key: key);

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
                    fishes: widget.fishes, scrollController: scrollController);
              }),
        )
      ],
    );
  }
}

class FishDetails extends StatelessWidget {
  const FishDetails({
    Key key,
    @required this.fishes,
    @required this.scrollController,
  }) : super(key: key);

  final List<Fish> fishes;
  final ScrollController scrollController;

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
          controller: scrollController,
          child: Column(children: [
            SizedBox(height: 16),
            Text("Résultats :", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            if (fishes != null && fishes.length > 0)
              Column(
                children: fishes
                    .map((fish) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(fish.name,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic)),
                            Text(
                                " (${(fish.confidence * 100).toStringAsFixed(0)} %)",
                                style: TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.italic))
                          ],
                        ))
                    .toList(),
              ),
            SizedBox(height: 16),
            Text("Plus d'informations"),
            Icon(Icons.expand_more_outlined),
            Container(height: 500)
          ]),
        ),
      ),
    );
  }
}
