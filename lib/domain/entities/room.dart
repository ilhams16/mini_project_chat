class Room {
  String from;
  String to;

  Room({required this.from, required this.to});

  Map<String, dynamic> toJson() {
    return {'from': from, 'to': to};
  }
}
