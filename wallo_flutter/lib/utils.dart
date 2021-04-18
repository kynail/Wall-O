import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

String getServerMessage(http.Response response, bool isError) {
  String message = jsonDecode(response.body)["message"];

  return message != null
      ? "Une erreur s'est produite, veuillez réessayer qzdkzq kqd qj kqj kz jqkj z qjk jz jkqj kzj kqj kz dqzd qqz q zq  zq z qz q z q "
      : isError
          ? "Une erreur s'est produite, veuillez réessayer"
          : null;
}
