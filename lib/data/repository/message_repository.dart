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

    // var messages = List<Map<String, dynamic>>.from(jsonArray);
    return jsonArray;
  }
}
