import 'package:flutter/material.dart';
import 'package:wallo_flutter/models/aquadex_fish.dart';
import 'package:wallo_flutter/models/user.dart';
import 'package:wallo_flutter/views/home/fishinfo.dart';
import 'package:wallo_flutter/views/floating_page_top_bar.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class Aquadex extends StatefulWidget {
  final PageController pageController;
  final List<AquadexFish> aquadex;
  final User user;
  final Function() onCloseArrowTap;

  const Aquadex({
    Key key,
    @required this.aquadex,
    @required this.pageController,
    @required this.user,
    @required this.onCloseArrowTap,
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

    return Stack(children: <Widget>[
      Image.asset(
        "assets/fonddex.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 90, top: 20),
          child: Column(children: [
            FloatingPageTopBar(
              onCloseArrowTap: widget.onCloseArrowTap,
              title: "Aquadex",
            ),
            Text("Poissons photographié : ${widget.user.totalFishes}"),
            Expanded(
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
                  crossAxisCount: 3,

                  childAspectRatio:
                      (MediaQuery.of(context).size.width / 3) / 180,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,

                  children: widget.aquadex
                      .map(
                        (fish) => FishInfo(
                          fishId: fish.id,
                          fishname: fish.name,
                          urlfish: fish.image,
                          description: fish.desc,
                          scientificName: fish.scientificName,
                          slug: fish.slug,
                          isunlocked: widget.user.aquadex.contains(fish.id),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ]))
    ]);
  }
}
