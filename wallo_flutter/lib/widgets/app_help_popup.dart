import 'package:flutter/material.dart';

class AppHelpPopup extends StatelessWidget {
  const AppHelpPopup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Voici comment prendre une bonne photo :"),
      content: _popupContent(),
      actions: <Widget>[
        Center(
          child: Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("J'ai compris !"),
            ),
          ),
        )
      ],
    );
  }

  Column _popupContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HelpFishCard(
          subtitle: "",
          assets: "assets/bon-poisson.jpg",
        ),
        Text("Les situations suivantes donneront de mauvais résultats :"),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: HelpFishCard(
                subtitle: "Trop loin",
                assets: "assets/poisson-loin.jpg",
              ),
            ),
            Expanded(
              flex: 3,
              child: HelpFishCard(
                subtitle: "Mauvais angle",
                assets: "assets/poisson-mauvais-angle.jpg",
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: HelpFishCard(
                subtitle: "Flou",
                assets: "assets/poisson-flou.jpg",
              ),
            ),
            Expanded(
              flex: 3,
              child: HelpFishCard(
                subtitle: "Plusieurs espèces",
                assets: "assets/plusieurs-especes.jpg",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HelpFishCard extends StatelessWidget {
  const HelpFishCard({
    Key key,
    @required this.assets,
    this.subtitle,
  }) : super(key: key);

  final String assets;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(
            assets,
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 15,
          margin: EdgeInsets.all(10),
          borderOnForeground: true,
        ),
        Text(subtitle),
      ],
    );
  }
}
