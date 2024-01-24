class Message {
  String username;
  String text;
  int timestamp;

  Message(
      {required this.username, required this.text, required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'text': String text,
        'timestamp': int timestamp
      } =>
        Message(username: username, text: text, timestamp: timestamp),
      _ => throw const FormatException("Gagal")
    };
  }
}
