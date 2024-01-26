import 'package:flutter/material.dart';
import 'package:mini_project_chat/presentation/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentPageIndex = 0;

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatting Apps Demo"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.lightBlueAccent,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
                selectedIcon: Icon(Icons.login),
                icon: Icon(Icons.login_outlined),
                label: "Login"),
            NavigationDestination(
                selectedIcon: Icon(Icons.people),
                icon: Icon(Icons.people_outline),
                label: "Register")
          ]),
      body: <Widget>[
        /// Login page
        Card(
          child: Center(
            child: Container(
              height: 500,
              width: 500,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Username"),
                        hintText: "Masukkan Username"),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                    username: _usernameController.text)));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 70,
                        child: const Center(
                          child: Text("Login"),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),

        /// Registration page
        Card(
          child: Center(
            child: Container(
              height: 500,
              width: 500,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Username"),
                        hintText: "Masukkan Username"),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 70,
                        child: const Center(
                          child: Text("Register"),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }
}
