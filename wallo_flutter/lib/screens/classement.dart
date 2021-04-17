import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallo_flutter/theme.dart';
import 'package:wallo_flutter/widgets/custom_drawer.dart';

class Classement extends StatelessWidget {
  const Classement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      appBar: AppBar(
          title: Text("Classement"),
          iconTheme: IconThemeData(color: Colors.white)),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClassementCard(classement: 1, avatar: "https://avatars.dicebear.com/api/female/fjtedlolgf.svg", name: "name", score: "123",color: Colors.pink,),
              ClassementCard(classement: 1, avatar: "https://avatars.dicebear.com/api/female/fjotedolgf.svg", name: "name", score: "123",color: Colors.purple,),
              ClassementCard(classement: 1, avatar: "https://avatars.dicebear.com/api/female/fjotedlolgf.svg", name: "name", score: "123", color: Colors.lightBlue,),
              ClassementCard(classement: 1, avatar: "https://avatars.dicebear.com/api/female/fjotedlolf.svg", name: "name", score: "123",),
              ClassementCard(classement: 1, avatar: "https://avatars.dicebear.com/api/female/fjoteolgf.svg", name: "name", score: "123",),
            ],
          ) ,
        ),
      ),
    );
  }
}

class ClassementCard extends StatelessWidget {
  const ClassementCard({
    Key key, this.name, this.classement, this.avatar, this.score, this.color,
  }) : super(key: key);
  final int classement;
  final String avatar;
  final  String name;
  final String score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(classement.toString()),
            Container(
              width: 50,
              height: 50,
              child: SvgPicture.network(
                avatar,
                semanticsLabel: 'Avatar',
                width: 50,
                placeholderBuilder: (BuildContext context) =>
                    Container(child: const CircularProgressIndicator()),
              ),
            ),
            Text(name),
              ],
            ),
          ),
          Text(score),
        ]),
      )
    );
  }
}
