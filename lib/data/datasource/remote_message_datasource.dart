import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mini_project_chat/domain/entities/message.dart';

class RemoteMessageDataSource {
  static const URL = 'http://127.0.0.1:8080';

  Future<String> getMessage(String room) async {
    var response = await http.get(Uri.parse('${URL}/api/chat/${room}'));
    return response.body;
  }

  Future<String> sendMessage(Map<String, dynamic> message) async {
    var response = await http.post(Uri.parse('${URL}/api/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': message['id'],
          'from': message['username'],
          'text': message['text']
        }));
    return response.body;
  }
}
