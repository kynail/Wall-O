import 'package:flutter/material.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/screens/home/aquadex.dart';
import 'package:wallo_flutter/screens/home/import.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';
import 'package:wallo_flutter/redux/user/user_actions_old.dart';

import '../theme.dart';
import 'home/camera.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          bottom: TabBar(
            tabs: [
              Tab(
                  icon: Icon(
                Icons.image,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.camera,
                color: Colors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.set_meal,
                color: Colors.white,
              )),
            ],
          ),
          title: Text('Wall-O'),
        ),
        body: TabBarView(
          children: [
            Import(),
            Camera(),
            Aquadex(),
          ],
        ),
      ),
    );
  }
}
