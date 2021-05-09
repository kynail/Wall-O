import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String getServerMessage(http.Response response, bool isError) {
  String message = jsonDecode(response.body)["message"];

  return message != null
      ? message
      : isError
          ? "Une erreur s'est produite, veuillez réessayer"
          : null;
}

String convertToBase64(String filePath) {
  final bytes = File(filePath).readAsBytesSync();

  return base64Encode(bytes);
}
