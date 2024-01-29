import 'package:flutter/material.dart';
import 'package:mini_project_chat/data/repository/message_repository.dart';
import 'package:mini_project_chat/data/repository/user_repository.dart';
import 'package:mini_project_chat/domain/entities/room.dart';
import 'package:mini_project_chat/presentation/chat_page.dart';
import 'package:mini_project_chat/presentation/login_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(username: username);
}

class _HomePageState extends State<HomePage> {
  final String username;
  _HomePageState({required this.username});
  final TextEditingController _toController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chatting Apps Demo"),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: "Log Out",
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
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
                    // child: Text("${listRoom[i]}")
                    child: Card(
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: MessageRepository()
                                  .getUsers(listRoom[i].toString()),
                              builder: (context, snapshot) {
                                var listUsers = snapshot.data!;
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    style: BorderStyle.solid)),
                                            width: 50,
                                            child: const Icon(Icons.person),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${listUsers[0] != username ? listUsers[0] : listUsers[1]}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    FutureBuilder(
                                                        future: MessageRepository()
                                                            .getMessage(
                                                                listRoom[i]
                                                                    .toString()),
                                                        builder: (context,
                                                            snapshot) {
                                                          var listMessage =
                                                              snapshot.data!;
                                                          var index =
                                                              listMessage
                                                                      .length -
                                                                  1;
                                                          if (listMessage
                                                              .isEmpty) {
                                                            return const Text(
                                                                "Belum ada pesan");
                                                          } else {
                                                            // for (var i = 0;
                                                            //     i <
                                                            //         listMessage
                                                            //             .length;
                                                            //     i++) {
                                                            //   if (listMessage[i]
                                                            //           [
                                                            //           'username'] !=
                                                            //       username) {
                                                            //     index = i;
                                                            //   }
                                                            // }
                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Text(
                                                                              "${listMessage[index]['text']!}",
                                                                              maxLines: 2,
                                                                            ),
                                                                          )),
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Text(
                                                                            "${listMessage[index]['timestamp']!}"),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        })
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                );
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
              return const Text('Belum ada chat');
            }
          },
        ),
        floatingActionButton: Container(
            decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: IconButton(
              iconSize: 36,
              padding: const EdgeInsets.all(10),
              icon: const Icon(Icons.message),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Memulai Chat Baru'),
                    content: TextField(
                      controller: _toController,
                      decoration: const InputDecoration(
                          label: Text("Username"),
                          hintText: "Masukkan username. . ."),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _toController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          UserRepository().createRoom(
                              Room(from: username, to: _toController.text));
                          Navigator.pop(context);
                          _toController.clear();
                          setState(() {});
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            )));
  }
}
