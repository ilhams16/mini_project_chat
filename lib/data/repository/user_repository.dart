import 'package:mini_project_chat/data/datasource/remote_user_datasource.dart';
import 'dart:convert';

import 'package:mini_project_chat/domain/entities/room.dart';

class UserRepository {
  var remoteUserDatasource = RemoteUserDataSource();

  Future<List> getRoom(String username) async {
    var source = remoteUserDatasource.getRoom(username);
    var jsonArray = jsonDecode(await source)['data'];
    var listRoom = [];
    listRoom = List<String>.from(jsonArray['rooms']);
    return listRoom;
  }

  Future<bool> createRoom(Room room) async {
    var response = await remoteUserDatasource.postRoom(room.toJson());
    return jsonDecode(response)['data'];
  }
}
