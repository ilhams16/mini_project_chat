import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteUserDataSource {
  static const URL = 'http://127.0.0.1:8080';

  Future<String> getRoom(String username) async {
    var response = await http.get(Uri.parse('${URL}/api/user/${username}'));
    return response.body;
  }
}
