import 'package:flutter/material.dart';
import 'package:mini_project_chat/presentation/chat_page.dart';
import 'package:mini_project_chat/presentation/home_page.dart';
import 'package:mini_project_chat/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting Apps Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: ChatPage("8SFkk"),
    );
  }
}