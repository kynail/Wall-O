import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

class Contact extends StatelessWidget {
  const Contact({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Contact"),
          iconTheme: IconThemeData(color: Colors.white)),
      drawer: CustomDrawer(),
      body: Container(
        child: Center(
            child: Text("Ceci est la page Contact",
                style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
