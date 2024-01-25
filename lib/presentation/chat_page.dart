import 'package:flutter/material.dart';
import 'package:mini_project_chat/data/repository/message_repository.dart';
import 'package:mini_project_chat/domain/entities/message.dart';
import 'package:mini_project_chat/presentation/login_page.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String username;
  ChatPage({required this.id, required this.username});

  @override
  State<ChatPage> createState() =>
      _ChatPageState(id: this.id, username: this.username);
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  final String id;
  final String username;
  _ChatPageState({required this.id, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chatting Apps Demo"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
        ),
        // body: FutureBuilder(
        //     future: MessageRepository().getMessage("8SFkk"),
        //     builder: (context, snapshot) {
        //       return Text("${snapshot.error}");
        //     }),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: MessageRepository().getMessage(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var listMessage = snapshot.data!;
                  return ListView(
                    children: List.generate(listMessage.length, (i) {
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              child: Text('${listMessage[i]["username"]}'),
                            ),
                            Text('${listMessage[i]["text"]}'),
                            Text('${listMessage[i]["timestamp"]}'),
                          ],
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
            )),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Masukkan Pesan...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        MessageRepository().sendMessage(Message(
                          id: id,
                          username: username,
                          text: _messageController.text,
                        ));
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
