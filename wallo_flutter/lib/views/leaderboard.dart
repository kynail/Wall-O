import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallo_flutter/models/avatar.dart';
import 'package:wallo_flutter/models/user.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key key, @required this.leaderboard}) : super(key: key);

  final List<User> leaderboard;

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: widget.leaderboard.map((user) {
            var index = widget.leaderboard.indexOf(user) + 1;
            return ClassementCard(
                classement: index,
                name: user.firstName + " " + user.lastName,
                avatar: user.avatar,
                score: user.level.totalXp,
                color: Colors.white);
          }).toList(),
          // children: [
          //   ClassementCard(
          //       classement: 1,
          //       avatar:
          //           "https://avatars.dicebear.com/api/female/fjtedlolgf.svg",
          //       name: "name",
          //       score: "123",
          //       color: Colors.pink),
          //   ClassementCard(
          //       classement: 1,
          //       avatar:
          //           "https://avatars.dicebear.com/api/female/fjotedolgf.svg",
          //       name: "name",
          //       score: "123",
          //       color: Colors.purple),
          //   ClassementCard(
          //       classement: 1,
          //       avatar:
          //           "https://avatars.dicebear.com/api/female/fjotedlolgf.svg",
          //       name: "name",
          //       score: "123",
          //       color: Colors.lightBlue),
          //   ClassementCard(
          //       classement: 1,
          //       avatar:
          //           "https://avatars.dicebear.com/api/female/fjotedlolf.svg",
          //       name: "name",
          //       score: "123"),
          //   ClassementCard(
          //       classement: 1,
          //       avatar: "https://avatars.dicebear.com/api/female/fjoteolgf.svg",
          //       name: "name",
          //       score: "123"),
          // ],
        ),
      ),
    );
  }
}

class ClassementCard extends StatelessWidget {
  const ClassementCard({
    Key key,
    @required this.name,
    @required this.classement,
    @required this.avatar,
    @required this.score,
    @required this.color,
  }) : super(key: key);
  final int classement;
  final Avatar avatar;
  final String name;
  final int score;
  final Color color;

  static final colors = [Colors.pink, Colors.purple, Colors.lightBlue];

  @override
  Widget build(BuildContext context) {
    final isTopPlayer = (classement - 1) < 3;

    return Card(
        elevation: 4,
        color: isTopPlayer ? colors[classement - 1] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(classement.toString(),
                      style: TextStyle(
                          color: isTopPlayer ? Colors.white : Colors.black)),
                  SizedBox(width: 16),
                  Container(
                    width: 50,
                    height: 50,
                    child: SvgPicture.network(
                      avatar.seed != null
                          ? "https://avatars.dicebear.com/api/${avatar.type}/${avatar.seed}.svg"
                          : "https://avatars.dicebear.com/api/human/default.svg",
                      semanticsLabel: 'Avatar',
                      width: 50,
                      placeholderBuilder: (BuildContext context) => Container(
                          child:
                              const CircularProgressIndicator(strokeWidth: 2)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: Text(name,
                        style: TextStyle(
                            color: isTopPlayer ? Colors.white : Colors.black)),
                  ),
                ],
              ),
            ),
            Text(score.toString(),
                style: TextStyle(
                    color: isTopPlayer ? Colors.white : Colors.black)),
          ]),
        ));
  }
}
