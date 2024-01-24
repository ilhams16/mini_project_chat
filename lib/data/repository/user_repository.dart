import 'package:mini_project_chat/data/datasource/remote_user_datasource.dart';
import 'dart:convert';

class UserRepository {
  var remoteUserDatasource = RemoteUserDataSource();

  Future<List> getRoom(String username) async {
    var source = remoteUserDatasource.getRoom(username);
    var jsonArray = jsonDecode(await source)['data'];
    var listRoom = [];
    listRoom = List<String>.from(jsonArray['rooms']);
    return listRoom;
  }
}
