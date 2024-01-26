import 'package:flutter/material.dart';
import 'package:mini_project_chat/data/repository/message_repository.dart';
import 'package:mini_project_chat/domain/entities/message.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String username;
  const ChatPage({super.key, required this.id, required this.username});

  @override
  State<ChatPage> createState() =>
      // ignore: no_logic_in_create_state
      _ChatPageState(id: id, username: username);
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final String id;
  final String username;
  _ChatPageState({required this.id, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chatting Apps Demo"),
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
                      return Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        margin: (listMessage[i]['username'] == username
                            ? const EdgeInsets.fromLTRB(100, 10, 10, 10)
                            : const EdgeInsets.fromLTRB(10, 10, 100, 10)),
                        child: Column(
                          crossAxisAlignment:
                              (listMessage[i]['username'] == username
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start),
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: (listMessage[i]["username"] == username
                                      ? Colors.lightBlueAccent
                                      : const Color.fromARGB(255, 140, 219, 255)),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                '${listMessage[i]["text"]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              '${listMessage[i]["timestamp"]}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const Text("Gagal");
                }
              },
            )),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Masukkan Pesan...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
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
