import 'package:flutter/material.dart';
import 'package:mini_project_chat/data/repository/message_repository.dart';
import 'package:mini_project_chat/data/repository/user_repository.dart';
import 'package:mini_project_chat/presentation/chat_page.dart';
import 'package:mini_project_chat/presentation/login_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({required this.username});

  @override
  State<HomePage> createState() => _HomePageState(username: this.username);
}

class _HomePageState extends State<HomePage> {
  final String username;
  _HomePageState({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting Apps Demo"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: UserRepository().getRoom(username),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var listRoom = snapshot.data!;
            return ListView(
              children: List.generate(listRoom.length, (i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatPage(
                            id: listRoom[i].toString(), username: username)));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        // Text('${listRoom[i]}')
                        FutureBuilder(
                            future: MessageRepository()
                                .getMessage(listRoom[i].toString()),
                            builder: (context, snapshot) {
                              var listMessage = snapshot.data!;
                              var index = 0;
                              for (var i = 0; i < listMessage.length; i++) {
                                if (listMessage[i]['username'] != username) {
                                  index = i;
                                }
                              }
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  style: BorderStyle.solid)),
                                          width: 50,
                                          child: Icon(Icons.person),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${listMessage[index]['username']}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${listMessage[index]['text']}",
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                              "${listMessage[index]['timestamp']}"),
                                        )
                                      ],
                                    ),
                                  )
                                  // Text("${listMessage[index]['username']}"),
                                  // Text("${listMessage[index]['text']}"),
                                  // Text("${listMessage[index]['timestamp']}"),
                                ],
                              );
                              // Text("${listMessage[index]['username']}");
                            })
                      ],
                    ),
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Text('Belum ada chat');
          }
        },
      ),
    );
  }
}
