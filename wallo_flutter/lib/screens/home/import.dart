import 'package:flutter/material.dart';
import 'package:wallo_flutter/widgets/loading_button.dart';

class Import extends StatelessWidget {
  const Import({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image (image: NetworkImage("https://media.gerbeaud.net/2019/11/640/amphiprion-ocellaris-poisson-clown-pacifique.jpg"),),
        ),
        LoadingButton(
          isLoading: false,
          onPressed: () {
          },
          child: Text(
            "Importer",
            style: TextStyle(color: Colors.white),
          ))],
    );
  }
}
