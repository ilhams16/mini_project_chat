import 'package:flutter/material.dart';
import 'package:mini_project_chat/data/repository/message_repository.dart';
import 'package:mini_project_chat/presentation/login_page.dart';

class ChatPage extends StatefulWidget {
  late String room;
  ChatPage(this.room);

  @override
  State<ChatPage> createState() => _ChatPageState(this.room);
}

class _ChatPageState extends State<ChatPage> {
  late String room;
  _ChatPageState(this.room);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting Apps Demo"),
        centerTitle: true,
      ),
      // body: FutureBuilder(
      //     future: MessageRepository().getMessage("8SFkk"),
      //     builder: (context, snapshot) {
      //       return Text("${snapshot.error}");
      //     }),
      body: FutureBuilder(
        future: MessageRepository().getMessage(room),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var listMessage = snapshot.data!;
            return ListView(
              children: List.generate(listMessage.length, (i) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => ChatPage(listMessage[i])));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text('${listMessage[i]["username"]}'),
                        Text('${listMessage[i]["text"]}'),
                        Text('${listMessage[i]["timestamp"]}'),
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Text("Gagal");
          }
        },
      ),
    );
  }
}
