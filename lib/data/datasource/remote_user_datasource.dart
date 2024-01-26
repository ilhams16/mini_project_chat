import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteUserDataSource {
  // ignore: constant_identifier_names
  static const URL = 'http://127.0.0.1:8080';

  Future<String> getRoom(String username) async {
    var response = await http.get(Uri.parse('$URL/api/user/$username'));
    return response.body;
  }

  Future<String> postRoom(Map<String, dynamic> room) async {
    var response = await http.post(Uri.parse('$URL/api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{'from': room['from'], 'to': room['to']}));
    return response.body;
  }
}
