import 'package:flutter/material.dart';
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
                        builder: (context) => ChatPage(listRoom[i])));
                  },
                  child: Card(
                    child: Column(
                      children: [Text('${listRoom[i]}')],
                    ),
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Text('Belum ada data');
          }
        },
      ),
    );
  }
}
