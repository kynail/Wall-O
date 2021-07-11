import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/views/home/fishinfo.dart';

class Aquadex extends StatefulWidget {
  final PageController pageController;
  final List<AquadexFish> aquadex;

  const Aquadex({
    Key key,
    @required this.aquadex,
    @required this.pageController,
  }) : super(key: key);

  @override
  _AquadexState createState() => _AquadexState();
}

class _AquadexState extends State<Aquadex> {
  bool reachTopGrid = true;
  bool changePage = false;
  bool isScrollUpdated = false;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  _scrollListener() async {
    ScrollPosition position = _controller.position;
    if (_controller.offset == position.minScrollExtent) {
      if (reachTopGrid == false) {
        setState(() {
          reachTopGrid = true;
        });
      }
    } else {
      if (reachTopGrid == true) {
        setState(() {
          reachTopGrid = false;
        });
      }
    }
  }

  _onStartScroll(ScrollMetrics metrics) {
    if (reachTopGrid == true) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (isScrollUpdated == false) {
          setState(() {
            changePage = true;
          });
        }
      });
    }
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    if (isScrollUpdated == false) {
      setState(() {
        isScrollUpdated = true;
      });
    }
  }

  _onEndScroll(ScrollMetrics metrics) {
    if (isScrollUpdated == true) {
      setState(() {
        isScrollUpdated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (changePage == true) {
      widget.pageController.previousPage(
          duration: Duration(milliseconds: 600), curve: Curves.fastOutSlowIn);
      setState(() {
        changePage = false;
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            _onStartScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollUpdateNotification) {
            _onUpdateScroll(scrollNotification.metrics);
          } else if (scrollNotification is ScrollEndNotification) {
            _onEndScroll(scrollNotification.metrics);
          }
          return true;
        },
        child: GridView.count(
          controller: _controller,
          crossAxisCount: 2,
          children: widget.aquadex
              .map(
                (fish) => FishInfo(
                  fishname: fish.name,
                  urlfish: fish.image,
                  description: fish.desc,
                  scientificName: fish.scientificName,
                  slug: fish.slug,
                  isunlocked: false,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
