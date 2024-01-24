import 'package:flutter/material.dart';
import 'package:mini_project_chat/data/datasource/remote_user_datasource.dart';
import 'package:mini_project_chat/data/repository/user_repository.dart';
import 'package:mini_project_chat/presentation/chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting Apps Demo"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: UserRepository().getRoom('adinugraha'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var listRoom = snapshot.data!;
            return ListView(
              children: List.generate(listRoom.length, (i) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context)=>ChatPage(listRoom[i]))
                    // );
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
