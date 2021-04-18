class ServerMessage {
  ServerMessage({this.success, this.message, this.data});

  bool success;
  String message;
  Map<String, dynamic> data;

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    return ServerMessage(
        success: json['success'], message: json['message'], data: json["data"]);
  }

  @override
  String toString() {
    return 'ServerMessage: {success: $success, message: $message, data: $data}';
  }
}
