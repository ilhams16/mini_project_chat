class Message {
  String id;
  String username;
  String text;

  Message({required this.id, required this.username, required this.text});

  factory Message.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': String id, 'username': String username, 'text': String text} =>
        Message(id: id, username: username, text: text),
      _ => throw const FormatException("Gagal")
    };
  }
  Map<String, dynamic> toJson() {
    return {'id': this.id, 'username': this.username, 'text': this.text};
  }
}
