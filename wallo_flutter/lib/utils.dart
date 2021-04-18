import 'dart:convert';
import 'package:http/http.dart' as http;

String getServerMessage(http.Response response, bool isError) {
  String message = jsonDecode(response.body)["message"];

  return message != null
      ? message
      : isError
          ? "Une erreur s'est produite, veuillez réessayer"
          : null;
}
