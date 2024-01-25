import 'package:flutter/material.dart';
import 'package:mini_project_chat/presentation/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentPageIndex = 0;

  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting Apps Demo"),
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
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Username"),
                        hintText: "Masukkan Username"),
                  ),
                  SizedBox(
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
                        padding: EdgeInsets.all(5),
                        width: 70,
                        child: Center(
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
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Username"),
                        hintText: "Masukkan Username"),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  OutlinedButton(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 70,
                        child: Center(
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
