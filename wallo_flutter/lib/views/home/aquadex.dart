import 'package:flutter/material.dart';
import 'package:wallo_flutter/views/home/fishinfo.dart';

class Aquadex extends StatelessWidget {
  const Aquadex({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [
      FishInfo(
        fishname: "Poisson clown",
        urlfish:
            "https://media.gerbeaud.net/2019/11/640/amphiprion-ocellaris-poisson-clown-pacifique.jpg",
            description: "Goldfish are lively and to slow species. However, they will be calm and peaceful with any roommate over half their size. Beware of certain plants, and prefer aquatic plants with solid leaves like Anubias with a classic plant Anubias nana for example",
      ),
      FishInfo(
        fishname: "Poisson clown",
        urlfish:
            "https://media.gerbeaud.net/2019/11/640/amphiprion-ocellaris-poisson-clown-pacifique.jpg",
            description: "test",
      ),
    ]);
  }
}
