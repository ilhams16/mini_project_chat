import 'dart:convert';

import 'package:mini_project_chat/data/datasource/remote_message_datasource.dart';
import 'package:mini_project_chat/domain/entities/message.dart';

class MessageRepository {
  var remoteMessageDatasource = RemoteMessageDataSource();

  Future<List> getMessage(String room) async {
    var source = remoteMessageDatasource.getMessage(room);
    var jsonArray =
        (jsonDecode(await source)['data']['messages'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .toList();
    return jsonArray;
  }

  Future<bool> sendMessage(Message message) async {
    var response = await remoteMessageDatasource.sendMessage(message.toJson());
    return jsonDecode(response)['data'];
  }
}
