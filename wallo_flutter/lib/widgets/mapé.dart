import 'package:flutter/cupertino.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

class ShowMap extends StatefulWidget {
  ShowMap({Key key}) : super(key: key);

  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  final controller = MapController(
    location: LatLng(-21.340490, 55.476620),
  );

  void _gotoPos(double lat, double long) {
    controller.center = LatLng(lat, long);
  }

  void _onDoubleTap() {
    controller.zoom -= 0.5;
  }

  void ontapLocate(double lat, double long) {
    _gotoPos(lat, long);
  }

  Offset _dragStart;

  double _scaleStart = 1.0;

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;
    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.zoom = 12;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      onScaleStart: _onScaleStart,
      onScaleUpdate: _onScaleUpdate,
      onScaleEnd: (details) {
        print(
            "Location: ${controller.center.latitude}, ${controller.center.longitude}");
      },
      child: Stack(
        children: [
          Map(
            controller: controller,
            builder: (context, x, y, z) {
              final url =
                  'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
              return Image.network(
                url,
                fit: BoxFit.cover,
              );
            },
          )
        ],
      ),
    );
  }
}
