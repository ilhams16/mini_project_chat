class Message {
  String id;
  String username;
  String text;

  Message({required this.id, required this.username, required this.text});

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'text': text};
  }
}
